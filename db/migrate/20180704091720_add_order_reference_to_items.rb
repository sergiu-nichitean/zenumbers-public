class AddOrderReferenceToItems < ActiveRecord::Migration[5.2]
  def change
  	remove_column :amazon_order_items, :amazon_orders_id
  	add_reference :amazon_order_items, :amazon_order
  end
end
