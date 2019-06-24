class ExtraShipmentDataToEvent < ActiveRecord::Migration[5.2]
  def change
		remove_column :amazon_financial_events, :shipment_tax_withheld_total
		remove_column :amazon_financial_events, :shipment_tax_withheld_currency_code

		add_column :amazon_financial_events, :shipment_item_fee_adjusment_total, :float
		add_column :amazon_financial_events, :shipment_item_fee_adjusment_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_tax_withheld_total, :float
		add_column :amazon_financial_events, :shipment_item_tax_withheld_currency_code, :string
  end
end
