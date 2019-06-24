class CouponPaymentEvent < AmazonFinancialEvent
	def self.parse_and_create(event, company_id, event_day)
		self.create(
			posted_date: event['PostedDate'],
			coupon_id: event['CouponId'],
			seller_coupon_description: event['SellerCouponDescription'],
			clip_or_redemption_count: event['ClipOrRedemptionCount'],
			payment_event_id: event['PaymentEventId'],
			fee_total: self.fee_component_total(event),
			fee_currency_code: self.fee_component_currency(event),
			charge_amount_currency_amount: self.charge_component_total(event),
			charge_amount_currency_code: self.charge_component_currency(event),
			total_amount_currency_amount: self.currency_amount(event['TotalAmount']),
			total_amount_currency_code: self.currency_code(event['TotalAmount']),
			company_id: company_id,
			event_day: event_day
		)
	end
end
