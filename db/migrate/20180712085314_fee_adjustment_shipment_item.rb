class FeeAdjustmentShipmentItem < ActiveRecord::Migration[5.2]
  def change
		add_column :amazon_financial_events, :shipment_item_fee_adjustment_currency_code, :string
  end
end
