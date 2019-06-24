class ProductAdsPaymentEvent < AmazonFinancialEvent
		def self.parse_and_create(event, company_id, event_day)
			self.create(
				posted_date: event['postedDate'],
				transaction_type: event['transactionType'],
				invoice_id: event['invoiceId'],
				base_value_currency_amount: self.currency_amount(event['baseValue']),
				base_value_currency_code: self.currency_code(event['baseValue']),
				tax_value_currency_amount: self.currency_amount(event['taxValue']),
				tax_value_currency_code: self.currency_code(event['taxValue']),
				transaction_value_currency_amount: self.currency_amount(event['transactionValue']),
				transaction_value_currency_code: self.currency_code(event['transactionValue']),
				company_id: company_id,
				event_day: event_day
			)
		end
end
