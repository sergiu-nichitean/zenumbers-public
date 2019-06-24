class LoanServicingEvent < AmazonFinancialEvent
	def self.parse_and_create(event, company_id, event_day)
		self.create(
			loan_amount_currency_amount: self.currency_amount(event['LoanAmount']),
			loan_amount_currency_code: self.currency_code(event['LoanAmount']),
			source_business_event_type: event['SourceBusinessEventType'],
			company_id: company_id,
			event_day: event_day
		)
	end
end
