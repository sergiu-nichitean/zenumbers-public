class FbaLiquidationEvent < AmazonFinancialEvent
	def self.parse_and_create(event, company_id, event_day)
		self.create(
			posted_date: event['PostedDate'],
			original_removal_order_id: event['EnrollmentId'],
			liquidation_proceeds_amount_currency_amount: self.currency_amount(event['LiquidationProceedsAmount']),
			liquidation_proceeds_amount_currency_code: self.currency_code(event['LiquidationProceedsAmount']),
			liquidation_fee_amount_currency_amount: self.currency_amount(event['LiquidationFeeAmount']),
			liquidation_fee_amount_currency_code: self.currency_code(event['LiquidationFeeAmount']),
			company_id: company_id,
			event_day: event_day
		)
	end
end
