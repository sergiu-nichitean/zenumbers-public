class AddFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
  	remove_column :amazon_orders, :amz_id
  	remove_column :amazon_orders, :purchase_date
  	remove_column :amazon_orders, :payments_date

  	add_column :amazon_orders, :latest_ship_date, :string
	add_column :amazon_orders, :order_type, :string
	add_column :amazon_orders, :purchase_date, :string
	add_column :amazon_orders, :is_replacement_order, :boolean
	add_column :amazon_orders, :last_update_date, :datetime
	add_column :amazon_orders, :amazon_order_id, :string
	add_column :amazon_orders, :number_of_items_shipped, :integer
	add_column :amazon_orders, :ship_service_level, :string
	add_column :amazon_orders, :order_status, :string
	add_column :amazon_orders, :sales_channel, :string
	add_column :amazon_orders, :shipped_by_amazon_tfm, :boolean
	add_column :amazon_orders, :is_business_order, :boolean
	add_column :amazon_orders, :latest_delivery_date, :datetime
	add_column :amazon_orders, :number_of_items_unshipped, :integer
	add_column :amazon_orders, :payment_method_details, :string
	add_column :amazon_orders, :earliest_delivery_date, :string
	add_column :amazon_orders, :is_premium_order, :boolean
	add_column :amazon_orders, :order_total_currency_code, :string
	add_column :amazon_orders, :order_total_amount, :float
	add_column :amazon_orders, :earliest_ship_date, :datetime
	add_column :amazon_orders, :marketplace_id, :string
	add_column :amazon_orders, :fulfillment_channel, :string
	add_column :amazon_orders, :payment_method, :string
	add_column :amazon_orders, :shipping_address_city, :string
	add_column :amazon_orders, :shipping_address_address_type, :string
	add_column :amazon_orders, :shipping_address_postal_code, :string
	add_column :amazon_orders, :shipping_address_state_or_region, :string
	add_column :amazon_orders, :shipping_address_country_code, :string
	add_column :amazon_orders, :shipping_address_name, :string
	add_column :amazon_orders, :shipping_address_address_line_1, :string
	add_column :amazon_orders, :shipping_address_address_line_2, :string
	add_column :amazon_orders, :is_prime, :boolean
	add_column :amazon_orders, :shipment_service_level_category, :string
  end
end
