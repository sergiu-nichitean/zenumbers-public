class UpdateOrderItemsTable < ActiveRecord::Migration[5.2]
  def change
		remove_column :amazon_order_items,:amz_id
		remove_column :amazon_order_items,:sku
		remove_column :amazon_order_items,:product_name
		remove_column :amazon_order_items,:quantity_purchased
		remove_column :amazon_order_items,:currency
		remove_column :amazon_order_items,:item_price
		remove_column :amazon_order_items,:item_tax
		remove_column :amazon_order_items,:shipping_price
		remove_column :amazon_order_items,:shipping_tax

		add_column :amazon_order_items, :tax_collection_model, :string
		add_column :amazon_order_items, :tax_collection_responsible_party, :string
		add_column :amazon_order_items, :quantity_ordered, :integer
		add_column :amazon_order_items, :title, :string
		add_column :amazon_order_items, :shipping_tax_currency_code, :string
		add_column :amazon_order_items, :shipping_tax_amount, :float
		add_column :amazon_order_items, :promotion_discount_currency_code, :string
		add_column :amazon_order_items, :promotion_discount_amount, :float
		add_column :amazon_order_items, :condition_id, :string
		add_column :amazon_order_items, :is_gift, :boolean
		add_column :amazon_order_items, :asin, :string
		add_column :amazon_order_items, :seller_sku, :string
		add_column :amazon_order_items, :order_item_id, :string
		add_column :amazon_order_items, :product_info_number_of_items, :string
		add_column :amazon_order_items, :gift_wrap_tax_currency_code, :string
		add_column :amazon_order_items, :gift_wrap_tax_amount, :float
		add_column :amazon_order_items, :quantity_shipped, :integer
		add_column :amazon_order_items, :shipping_price_currency_code, :string
		add_column :amazon_order_items, :shipping_price_amount, :float
		add_column :amazon_order_items, :gift_wrap_price_currency_code, :string
		add_column :amazon_order_items, :gift_wrap_price_amount, :float
		add_column :amazon_order_items, :condition_subtype_id, :string
		add_column :amazon_order_items, :item_price_currency_code, :string
		add_column :amazon_order_items, :item_price_amount, :float
		add_column :amazon_order_items, :item_tax_currency_code, :string
		add_column :amazon_order_items, :item_tax_amount, :float
		add_column :amazon_order_items, :shipping_discount_currency_code, :string
		add_column :amazon_order_items, :shipping_discount_amount, :float
  end
end
