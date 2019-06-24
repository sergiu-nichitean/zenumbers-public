class RetrochargeEvent < AmazonFinancialEvent

	def self.parse_and_create(event, company_id, event_day)
		self.create(
			retrocharge_event_type: event['RetrochargeEventType'],
			amazon_order_id: event['AmazonOrderId'],
			posted_date: event['PostedDate'],
			base_tax_currency_amount: self.currency_amount(event['BaseTax']),
			base_tax_currency_code: self.currency_code(event['BaseTax']),
			shipping_tax_currency_amount: self.currency_amount(event['ShippingTax']),
			shipping_tax_currency_code: self.currency_code(event['ShippingTax']),
			marketplace_name: event['MarketplaceName'],
			company_id: company_id,
			event_day: event_day
		)
	end

end
