class CreateAmazonListings < ActiveRecord::Migration[5.2]
  def change
    create_table :amazon_listings do |t|
    	t.string :sku
    	t.string :asin
    	t.string :title
    	t.float :per_unit_production_cost
    	t.float :per_unit_shipping_cost

    	t.references :company, foreign_key: true
      t.timestamps
    end
  end
end
