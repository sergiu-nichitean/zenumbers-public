json.extract! amazon_order_item, :id, :amz_id, :sku, :product_name, :quantity_purchased, :currency, :item_price, :item_tax, :shipping_price, :shipping_tax, :amazon_orders_id, :created_at, :updated_at
json.url amazon_order_item_url(amazon_order_item, format: :json)
