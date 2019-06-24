class ImagingServicesFeeEvent < AmazonFinancialEvent
		def self.parse_and_create(event, company_id, event_day)
			self.create(
				imaging_request_billing_item_id: event['ImagingRequestBillingItemID'],
				asin: event['ASIN'],
				posted_date: event['PostedDate'],
				fee_total: self.fee_component_total(event['FeeList']),
				fee_currency_code: self.fee_component_currency(event['FeeList']),
				company_id: company_id,
				event_day: event_day
			)
		end	
end
