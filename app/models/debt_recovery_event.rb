class DebtRecoveryEvent < AmazonFinancialEvent
	
	def self.parse_and_create(event, company_id, event_day)
		self.create(
			debt_recovery_type: event['DebtRecoveryType'],
			recovery_amount_currency_amount: self.currency_amount(event['RecoveryAmount']),
			recovery_amount_currency_code: self.currency_code(event['RecoveryAmount']),
			over_payment_credit_currency_amount: self.currency_amount(event['OverPaymentCredit']),
			over_payment_credit_currency_code: self.currency_code(event['OverPaymentCredit']),
			company_id: company_id,
			event_day: event_day
		)
	end

end
