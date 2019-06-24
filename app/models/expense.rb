class Expense < ApplicationRecord
  belongs_to :company
  belongs_to :amazon_listing

  def self.fetch_from_listings
		Company.all.each do |company|
			company.amazon_listings.each do |listing|

				if listing.expenses.where(expense_type: 'shipping').empty?
						puts "Creating empty shipping expense for listing with SKU: #{listing.sku}"
						listing.expenses.create(
							expense_type: 'shipping',
							company_id: company.id,
							description: 'Inbound shipping cost'
						)
				end

				if listing.expenses.where(expense_type: 'production').empty?
						puts "Creating empty production expense for listing with SKU: #{listing.sku}"
						listing.expenses.create(
							expense_type: 'production',
							company_id: company.id,
							description: 'Production cost'
						)
				end

			end
		end
	end

	def self.total_product_expenses(company, expense_type, start_date, end_date)
		total_cost = 0

		company.amazon_orders.where('purchase_date BETWEEN ? and ?', start_date, end_date).each do |order|
			order.amazon_order_items.each do |order_item|
				amazon_listing = AmazonListing.where(sku: order_item.seller_sku).first
				if amazon_listing
					per_period_cost = amazon_listing.expenses.where('expense_type = ? AND start_date < ? AND end_date > ?', expense_type, order.purchase_date, order.purchase_date).first
					general_cost = amazon_listing.expenses.where('expense_type = ? AND start_date IS NULL AND end_date IS NULL', expense_type).first
					if per_period_cost
						total_cost += per_period_cost.amount
					elsif general_cost
						total_cost += general_cost.amount.to_f
					end
				end
			end
		end

		-total_cost
	end

end
