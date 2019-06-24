class ChangeLatestShipDate < ActiveRecord::Migration[5.2]
  def change
  	change_column :amazon_orders, :latest_ship_date, :datetime
  end
end
