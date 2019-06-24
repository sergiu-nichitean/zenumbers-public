class Extra2ShipmentDataToEvent < ActiveRecord::Migration[5.2]
  def change
  	remove_column :amazon_financial_events, :transaction_posted_date
  	add_column :amazon_financial_events, :transaction_posted_date, :datetime

  	remove_column :amazon_financial_events, :base_tax
  	remove_column :amazon_financial_events, :shipping_tax
		add_column :amazon_financial_events, :base_tax_currency_amount, :float
		add_column :amazon_financial_events, :base_tax_currency_code, :string
		add_column :amazon_financial_events, :shipping_tax_currency_amount, :float
		add_column :amazon_financial_events, :shipping_tax_currency_code, :string
  end
end
