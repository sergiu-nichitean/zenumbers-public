class PayWithAmazonEvent < AmazonFinancialEvent

	def self.parse_and_create(event, company_id, event_day)
		self.create(
			seller_order_id: event['SellerOrderId'],
			transaction_posted_date: event['TransactionPostedDate'],
			business_object_type: event['BusinessObjectType'],
			sales_channel: event['SalesChannel'],
			charge_type: event['Charge'] ? event['Charge']['ChargeType'] : nil,
			charge_amount_currency_amount: event['Charge'] ? event['Charge']['ChargeAmount']['CurrencyAmount'] : nil,
			charge_amount_currency_code: event['Charge'] ? event['Charge']['ChargeAmount']['CurrencyCode'] : nil,
			fee_total: self.fee_component_total(event['FeeList']),
			fee_currency_code: self.fee_component_currency(event['FeeList']),
			payment_amount_type: event['PaymentAmountType'],
			amount_description: event['AmountDescription'],
			fulfillment_channel: event['FulfillmentChannel'],
			store_name: event['StoreName'],
			company_id: company_id,
			event_day: event_day
		)
	end

end
