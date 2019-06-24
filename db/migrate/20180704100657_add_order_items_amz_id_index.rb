class AddOrderItemsAmzIdIndex < ActiveRecord::Migration[5.2]
  def change
  	add_index :amazon_order_items, :order_item_id, unique: true
  end
end
