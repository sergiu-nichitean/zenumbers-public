class ChangePurchaseDate < ActiveRecord::Migration[5.2]
  def change
  	change_column :amazon_orders, :purchase_date, :datetime
  end
end
