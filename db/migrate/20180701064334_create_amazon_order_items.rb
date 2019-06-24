class CreateAmazonOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :amazon_order_items do |t|
      t.string :amz_id
      t.string :sku
      t.string :product_name
      t.string :quantity_purchased
      t.string :currency
      t.float :item_price
      t.float :item_tax
      t.float :shipping_price
      t.float :shipping_tax
      t.references :amazon_orders, foreign_key: true

      t.timestamps
    end
  end
end
