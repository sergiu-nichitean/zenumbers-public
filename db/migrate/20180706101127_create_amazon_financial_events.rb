class CreateAmazonFinancialEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :amazon_financial_events do |t|

      t.timestamps
    end
  end
end
