class AmazonListing < ApplicationRecord
	belongs_to :company
	has_many :expenses

	def self.fetch_from_orders
		Company.all.each do |company|
			company.amazon_orders.each do |order|
				order.amazon_order_items.each do |order_item|
					unless self.exists? sku: order_item.seller_sku
						puts "Creating listing with SKU: #{order_item.seller_sku}, ASIN: #{order_item.asin}, title: #{order_item.title}"
						company.amazon_listings.create(
							sku: order_item.seller_sku,
							asin: order_item.asin,
							title: order_item.title
						)
					end
				end
			end
		end
	end
end
