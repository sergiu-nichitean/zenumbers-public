class AddFieldsToFinancial < ActiveRecord::Migration[5.2]
  def change
  	add_reference :amazon_financial_events, :company
  	add_column :amazon_financial_events, :event_type, :string
  end
end
