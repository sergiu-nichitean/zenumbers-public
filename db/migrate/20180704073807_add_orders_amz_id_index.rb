class AddOrdersAmzIdIndex < ActiveRecord::Migration[5.2]
  def change
  	add_index :amazon_orders, :amazon_order_id, unique: true
  end
end
