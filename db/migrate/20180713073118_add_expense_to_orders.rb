class AddExpenseToOrders < ActiveRecord::Migration[5.2]
  def change
  	add_column :amazon_orders, :per_order_shipping_cost, :float
  	add_column :amazon_orders, :per_order_shipping_cost_currency, :string
  	add_column :amazon_listings, :per_unit_production_cost_currency, :string
    add_column :amazon_listings, :per_unit_shipping_cost_currency, :string
  end
end
