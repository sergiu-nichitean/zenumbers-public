class ServiceProviderCreditEvent < AmazonFinancialEvent
		def self.parse_and_create(event, company_id, event_day)
			self.create(
				provider_transaction_type: event['ProviderTransactionType'],
				seller_order_id: event['SellerOrderId'],
				marketplace_id: event['MarketplaceId'],
				marketplace_country_code: event['MarketplaceCountryCode'],
				seller_id: event['SellerId'],
				seller_store_name: event['SellerStoreName'],
				provider_id: event['ProviderId'],
				provider_store_name: event['ProviderStoreName'],
				company_id: company_id,
				event_day: event_day
			)
		end
end
