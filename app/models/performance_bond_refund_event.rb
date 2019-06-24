class PerformanceBondRefundEvent < AmazonFinancialEvent
		def self.parse_and_create(event, company_id, event_day)
			self.create(
				marketplace_country_code: event['MarketplaceCountryCode'],
				amount_currency_amount: self.currency_amount(event['Amount']),
				amount_currency_code: self.currency_code(event['Amount']),
				company_id: company_id,
				event_day: event_day
			)
		end
end
