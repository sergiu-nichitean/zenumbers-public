class CreateAmazonOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :amazon_orders do |t|
      t.string :amz_id
      t.string :purchase_date
      t.string :payments_date
      t.string :buyer_email
      t.string :buyer_name
      t.string :buyer_phone_number
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
