class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.float :amount
      t.string :expense_type
      t.datetime :start_date
      t.datetime :end_date
      t.references :company, foreign_key: true
      t.references :amazon_listing, foreign_key: true

      t.timestamps
    end
  end
end
