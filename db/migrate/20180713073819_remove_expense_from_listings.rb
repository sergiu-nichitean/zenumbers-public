class RemoveExpenseFromListings < ActiveRecord::Migration[5.2]
  def change
  	remove_column :amazon_listings, :per_unit_production_cost_currency
    remove_column :amazon_listings, :per_unit_shipping_cost_currency
    remove_column :amazon_listings, :per_unit_production_cost
    remove_column :amazon_listings, :per_unit_shipping_cost
  end
end
