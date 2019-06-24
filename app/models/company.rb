class Company < ApplicationRecord
	has_many :users
	has_many :amazon_orders, -> { order 'purchase_date desc' }
	has_many :amazon_financial_events
	has_many :amazon_listings
	has_many :expenses
end
