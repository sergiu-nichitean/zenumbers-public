class AdjustmentEvent < AmazonFinancialEvent
	def self.parse_and_create(event, company_id, event_day)
		self.create(
			adjustment_type: event['AdjustmentType'],
			adjustment_amount_currency_amount: self.currency_amount(event['AdjustmentAmount']),
			adjustment_amount_currency_code: self.currency_code(event['AdjustmentAmount']),
			adjustment_item_skus: self.adjustment_item_skus(event['AdjustmentItemList']),
			posted_date: event['PostedDate'],
      company_id: company_id,
      event_day: event_day
		)
	end

  def self.adjustment_item_skus(adjustment_item_list)
    adjustment_item_skus = []
    if adjustment_item_list
      if adjustment_item_list['AdjustmentItem'].is_a? Hash
        adjustment_item_skus << adjustment_item_list['AdjustmentItem']['SellerSKU']
      elsif adjustment_item_list['AdjustmentItem'].is_a? Array
        adjustment_item_list['AdjustmentItem'].each{|i| adjustment_item_skus << i['SellerSKU']}
      end
    end
    adjustment_item_skus.join(',')
  end
end
