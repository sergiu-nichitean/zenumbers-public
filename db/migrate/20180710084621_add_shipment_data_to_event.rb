class AddShipmentDataToEvent < ActiveRecord::Migration[5.2]
  def change
		remove_column :amazon_financial_events, :shipment_item_total, :float
		remove_column :amazon_financial_events, :shipment_item_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_charge_total, :float
		add_column :amazon_financial_events, :shipment_item_charge_currency_code, :string
		add_column :amazon_financial_events, :shipment_tax_withheld_total, :float
		add_column :amazon_financial_events, :shipment_tax_withheld_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_charge_adjustment_total, :float
		add_column :amazon_financial_events, :shipment_item_charge_adjustment_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_fee_total, :float
		add_column :amazon_financial_events, :shipment_item_fee_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_promotion_total, :float
		add_column :amazon_financial_events, :shipment_item_promotion_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_promotion_adjustment_total, :float
		add_column :amazon_financial_events, :shipment_item_promotion_adjustment_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_points_granted_total, :float
		add_column :amazon_financial_events, :shipment_item_points_granted_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_points_returned_total, :float
		add_column :amazon_financial_events, :shipment_item_points_returned_currency_code, :string
  end
end
