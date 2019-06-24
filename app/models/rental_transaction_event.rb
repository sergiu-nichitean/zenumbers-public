class RentalTransactionEvent < AmazonFinancialEvent

	def self.parse_and_create(event, company_id, event_day)
		self.create(
			amazon_order_id: event['AmazonOrderId'],
			rental_event_type: event['RentalEventType'],
			extension_length: event['ExtensionLength'],
			posted_date: event['PostedDate'],
			rental_charge_total: self.charge_component_total(event['RentalChargeList']),
			rental_charge_currency_code: self.charge_component_currency(event['RentalChargeList']),
			rental_fee_total: self.fee_component_total(event['RentalFeeList']),
			rental_fee_currency_code: self.fee_component_currency(event['RentalFeeList']),
			marketplace_name: event['MarketplaceName'],
			rental_initial_value_currency_amount: self.currency_amount(event['RentalInitialValue']),
			rental_initial_value_currency_code: self.currency_code(event['RentalInitialValue']),
			rental_reimbursement_currency_amount: self.currency_amount(event['RentalReimbursement']),
			rental_reimbursement_currency_code: self.currency_code(event['RentalReimbursement']),
			rental_tax_withheld_total: self.tax_withheld_total(event['RentalTaxWithheldList']),
			rental_tax_withheld_currency_code: self.tax_withheld_currency(event['RentalTaxWithheldList']),
			company_id: company_id,
			event_day: event_day
		)
	end

end
