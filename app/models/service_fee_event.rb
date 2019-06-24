class ServiceFeeEvent < AmazonFinancialEvent
		def self.parse_and_create(event, company_id, event_day)
			self.create(
				amazon_order_id: event['AmazonOrderId'],
				fee_reason: event['FeeReason'],
				fee_total: self.fee_component_total(event['FeeList']),
				fee_currency_code: self.fee_component_currency(event['FeeList']),
				seller_sku: event['SellerSKU'],
				fn_sku: event['FnSKU'],
				fee_description: event['FeeDescription'],
				asin: event['ASIN'],
				company_id: company_id,
				event_day: event_day
			)
		end
end
