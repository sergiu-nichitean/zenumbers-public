class SafetReimbursementEvent < AmazonFinancialEvent
	def self.parse_and_create(event, company_id, event_day)
		self.create(
			posted_date: event['PostedDate'],
			safet_claim_id: event['SAFETClaimId'],
			reimbursed_amount_currency_amount: self.currency_amount(event['ReimbursedAmount']),
			reimbursed_amount_currency_code: self.currency_code(event['ReimbursedAmount']),
			company_id: company_id,
			event_day: event_day
		)
	end
end
