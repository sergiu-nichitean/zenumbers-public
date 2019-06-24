class AddAdjustmentsToShipment < ActiveRecord::Migration[5.2]
  def change
		add_column :amazon_financial_events, :shipment_item_adjustment_skus, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_charge_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_charge_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_tax_withheld_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_tax_withheld_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_charge_adjustment_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_charge_adjustment_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_fee_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_fee_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_fee_adjustment_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_fee_adjustment_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_promotion_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_promotion_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_promotion_adjustment_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_promotion_adjustment_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_points_granted_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_points_granted_currency_code, :string
		add_column :amazon_financial_events, :shipment_item_adjustment_points_returned_total, :float
		add_column :amazon_financial_events, :shipment_item_adjustment_points_returned_currency_code, :string
  end
end
