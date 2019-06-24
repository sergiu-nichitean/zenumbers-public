require 'peddler'

class AmazonOrder < ApplicationRecord
  belongs_to :company
  has_many :amazon_order_items

  def self.fetch_from_amazon(delay)
  	Company.all.each do |company|
  		if company.amazon_orders.empty? || company.amazon_orders.where('purchase_date > ?', 24.hours.ago).count == 0
        puts "Company with ID #{company.id} doesn't have recorded orders in the last 24 hours, fetching orders."
        client = MWS.orders(marketplace: company.marketplace,
                        merchant_id: company.merchant_id,
                        auth_token: company.mws_auth_token,
                        aws_access_key_id: Rails.configuration.mws['aws_access_key_id'],
                        aws_secret_access_key: Rails.configuration.mws['aws_secret_access_key'])

        unless self.get_orders_recursively(client, company, delay)
          break
        end
      else
        puts "Company with ID #{company.id} has recorded orders in the last 24 hours, skipping."
      end
  	end
  end

  def self.get_orders_recursively(client, company, delay)
    stay_in_loop = true

  	if company.amazon_orders.empty?
  		orders_start_date = 10.years.ago
  	else
  		orders_start_date = company.amazon_orders.order(purchase_date: :desc).first.purchase_date
  	end

    begin
      orders_list = client.list_orders(company.marketplace, created_after: orders_start_date.iso8601).parse
      orders_array = orders_list['Orders']['Order']

      if orders_array.is_a? Hash
        orders_array = [orders_array];
      end

      orders_array.each do |order|
        begin
          company.amazon_orders.create(
            buyer_email: order['BuyerEmail'],
            buyer_name: order['BuyerName'],
            latest_ship_date: order['LatestShipDate'],
            order_type: order['OrderType'],
            purchase_date: order['PurchaseDate'],
            amazon_order_id: order['AmazonOrderId'],
            is_replacement_order: order['IsReplacementOrder'],
            last_update_date: order['LastUpdateDate'],
            number_of_items_shipped: order['NumberOfItemsShipped'],
            ship_service_level: order['ShipServiceLevel'],
            order_status: order['OrderStatus'],
            sales_channel: order['SalesChannel'],
            shipped_by_amazon_tfm: order['ShippedByAmazonTFM'],
            is_business_order: order['IsBusinessOrder'],
            latest_delivery_date: order['LatestDeliveryDate'],
            number_of_items_unshipped: order['NumberOfItemsUnshipped'],
            payment_method_details: order['PaymentMethodDetails'] ? order['PaymentMethodDetails']['PaymentMethodDetail'] : nil,
            earliest_delivery_date: order['EarliestDeliveryDate'],
            order_total_currency_code: order['OrderTotal'] ? order['OrderTotal']['CurrencyCode'] : nil,
            order_total_amount: order['OrderTotal'] ? order['OrderTotal']['Amount'] : nil,
            is_premium_order: order['IsPremiumOrder'],
            earliest_ship_date: order['EarliestShipDate'],
            marketplace_id: order['MarketplaceId'],
            fulfillment_channel: order['FulfillmentChannel'],
            payment_method: order['PaymentMethod'],
            shipping_address_city: order['ShippingAddress'] ? order['ShippingAddress']['City'] : nil,
            shipping_address_address_type: order['ShippingAddress'] ? order['ShippingAddress']['AddressType'] : nil,
            shipping_address_postal_code: order['ShippingAddress'] ? order['ShippingAddress']['PostalCode'] : nil,
            shipping_address_state_or_region: order['ShippingAddress'] ? order['ShippingAddress']['StateOrRegion'] : nil,
            shipping_address_country_code: order['ShippingAddress'] ? order['ShippingAddress']['CountryCode'] : nil,
            shipping_address_name: order['ShippingAddress'] ? order['ShippingAddress']['Name'] : nil,
            shipping_address_address_line_1: order['ShippingAddress'] ? order['ShippingAddress']['AddressLine1'] : nil,
            shipping_address_address_line_2: order['ShippingAddress'] ? order['ShippingAddress']['AddressLine2'] : nil,
            is_prime: order['IsPrime'],
            shipment_service_level_category: order['ShipmentServiceLevelCategory']
          )
          puts "Created order #{order['AmazonOrderId']}, Company ID: #{company.id}"
        rescue ActiveRecord::RecordNotUnique
          puts "Order already exists in DB: #{order['AmazonOrderId']}, Company ID: #{company.id}"
        end
      end

      if orders_array.count == 100
        puts "Got to 100 orders limit, getting next batch, Company ID: #{company.id}"
        self.get_orders_recursively(client, company, 0)
      end
    rescue Peddler::Errors::RequestThrottled
      updated_delay = delay + 1
      puts "AWS said request is throttled, delaying call for #{updated_delay} minutes, Company ID: #{company.id}"
      stay_in_loop = false
      FetchAmazonOrdersWorker.perform_in(updated_delay.minutes, updated_delay)
    end

    stay_in_loop
  end
end
