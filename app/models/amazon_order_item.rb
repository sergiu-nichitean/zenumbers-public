require 'peddler'

class AmazonOrderItem < ApplicationRecord
  belongs_to :amazon_order

  def self.fetch_from_amazon(delay)
  	orders_without_items = AmazonOrder.includes(:amazon_order_items).where(:amazon_order_items => { :id => nil })

  	orders_without_items.each do |order|
			puts "Order with ID #{order.amazon_order_id} doesn't have recorded order items, fetching items."
      client = MWS.orders(marketplace: order.company.marketplace,
                      merchant_id: order.company.merchant_id,
                      auth_token: order.company.mws_auth_token,
                      aws_access_key_id: Rails.configuration.mws['aws_access_key_id'],
                      aws_secret_access_key: Rails.configuration.mws['aws_secret_access_key'])

      unless self.get_order_items_recursively(client, order, delay)
      	break
      end
  	end
  end

  def self.get_order_items_recursively(client, order, delay)
    stay_in_loop = true

    begin
      orders_items = client.list_order_items(order.amazon_order_id).parse
      orders_items_array = orders_items['OrderItems']['OrderItem']

      if orders_items_array.is_a? Hash
        orders_items_array = [orders_items_array];
      end

      orders_items_array.each do |order_item|
        begin
          db_order_item = order.amazon_order_items.create!(
						tax_collection_model: order_item['TaxCollection'] ? order_item['TaxCollection']['Model'] : nil,
						tax_collection_responsible_party: order_item['TaxCollection'] ? order_item['TaxCollection']['ResponsibleParty'] : nil,
						quantity_ordered: order_item['QuantityOrdered'],
						title: order_item['Title'],
						shipping_tax_currency_code: order_item['ShippingTax'] ? order_item['ShippingTax']['CurrencyCode'] : nil,
						shipping_tax_amount: order_item['ShippingTax'] ? order_item['ShippingTax']['Amount'] : nil,
						promotion_discount_currency_code: order_item['PromotionDiscount'] ? order_item['PromotionDiscount']['CurrencyCode'] : nil,
						promotion_discount_amount: order_item['PromotionDiscount'] ? order_item['PromotionDiscount']['Amount'] : nil,
						condition_id: order_item['ConditionId'],
						is_gift: order_item['IsGift'],
						asin: order_item['ASIN'],
						seller_sku: order_item['SellerSKU'],
						order_item_id: order_item['OrderItemId'],
						product_info_number_of_items: order_item['ProductInfo']['NumberOfItems'],
						gift_wrap_tax_currency_code: order_item['GiftWrapTax'] ? order_item['GiftWrapTax']['CurrencyCode'] : nil,
						gift_wrap_tax_amount: order_item['GiftWrapTax'] ? order_item['GiftWrapTax']['Amount'] : nil,
						quantity_shipped: order_item['QuantityShipped'],
						shipping_price_currency_code: order_item['ShippingPrice'] ? order_item['ShippingPrice']['CurrencyCode'] : nil,
						shipping_price_amount: order_item['ShippingPrice'] ? order_item['ShippingPrice']['Amount'] : nil,
						gift_wrap_price_currency_code: order_item['GiftWrapPrice'] ? order_item['GiftWrapPrice']['CurrencyCode'] : nil,
						gift_wrap_price_amount: order_item['GiftWrapPrice'] ? order_item['GiftWrapPrice']['Amount'] : nil,
						condition_subtype_id: order_item['ConditionSubtypeId'],
						item_price_currency_code: order_item['ItemPrice'] ? order_item['ItemPrice']['CurrencyCode'] : nil,
						item_price_amount: order_item['ItemPrice'] ? order_item['ItemPrice']['Amount'] : nil,
						item_tax_currency_code: order_item['ItemTax'] ? order_item['ItemTax']['CurrencyCode'] : nil,
						item_tax_amount: order_item['ItemTax'] ? order_item['ItemTax']['Amount'] : nil,
						shipping_discount_currency_code: order_item['ShippingDiscount'] ? order_item['ShippingDiscount']['CurrencyCode'] : nil,
						shipping_discount_amount: order_item['ShippingDiscount'] ? order_item['ShippingDiscount']['Amount'] : nil
          )
          puts "Created order item #{order_item['OrderItemId']}, DB ID: #{db_order_item.id}, order ID: #{order.id}"
        rescue ActiveRecord::RecordNotUnique
          puts "Order item already exists in DB: #{order_item['OrderItemId']}, order ID: #{order.id}"
        end
      end

      # it's almost impossible that this will ever happen
      if orders_items_array.count == 100
        puts "Got to 100 order items limit, getting next batch, order ID: #{order.id}"
        self.get_order_items_recursively(client, order, 0)
      end
    rescue Peddler::Errors::RequestThrottled
      updated_delay = 1
      puts "AWS said request is throttled, delaying call for #{updated_delay} minutes, order ID: #{order.id}"
      stay_in_loop = false
      FetchAmazonOrderItemsWorker.perform_in(updated_delay.minutes, updated_delay)
    rescue Excon::Error::Timeout
    	updated_delay = 1
      puts "Request timeout, delaying call for #{updated_delay} minutes, order ID: #{order.id}"
      stay_in_loop = false
      FetchAmazonOrderItemsWorker.perform_in(updated_delay.minutes, updated_delay)
    end

    stay_in_loop
  end
end
