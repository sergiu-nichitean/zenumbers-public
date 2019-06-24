class RemovePhoneNumber < ActiveRecord::Migration[5.2]
  def change
  	remove_column :amazon_orders, :buyer_phone_number
  end
end
