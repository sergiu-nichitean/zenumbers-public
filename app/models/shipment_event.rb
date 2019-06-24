class ShipmentEvent < AmazonFinancialEvent

	def self.parse_and_create(event, company_id, event_day)
		self.create(
			amazon_order_id: event['AmazonOrderId'],
			seller_order_id: event['SellerOrderId'],
			marketplace_name: event['MarketplaceName'],
			order_charge_total: self.charge_component_total(event['OrderChargeList']),
			order_charge_currency_code: self.charge_component_currency(event['OrderChargeList']),
			order_charge_adjustment_total: self.charge_component_total(event['OrderChargeAdjustmentList']),
			order_charge_adjustment_currency_code: self.charge_component_currency(event['ShipmentFeeList']),
			shipment_fee_total: self.fee_component_total(event['ShipmentFeeList']),
			shipment_fee_currency_code: self.fee_component_currency(event['ShipmentFeeList']),
			shipment_fee_adjustment_total: self.fee_component_total(event['ShipmentFeeAdjustmentList']),
			shipment_fee_adjustment_currency_code:  self.fee_component_currency(event['ShipmentFeeAdjustmentList']),
			order_fee_total: self.fee_component_total(event['OrderFeeList']),
			order_fee_currency_code: self.fee_component_currency(event['OrderFeeList']),
			order_fee_adjustment_total: self.fee_component_total(event['OrderFeeAdjustmentList']),
			order_fee_adjustment_currency_code: self.fee_component_currency(event['OrderFeeAdjustmentList']),
			direct_payment_total: self.direct_payment_total(event['OrderFeeAdjustmentList']),
			direct_payment_currency_code: self.direct_payment_currency(event['OrderFeeAdjustmentList']),
			posted_date: event['PostedDate'],
      shipment_item_skus: self.shipment_item_skus(event['ShipmentItemList']),
      shipment_item_charge_total: self.shipment_item_charge_total(event['ShipmentItemList'], 'ItemChargeList'),
      shipment_item_charge_currency_code: self.shipment_item_charge_currency(event['ShipmentItemList'], 'ItemChargeList'),
      shipment_item_tax_withheld_total: self.shipment_tax_withheld_total(event['ShipmentItemList']),
      shipment_item_tax_withheld_currency_code: self.shipment_tax_withheld_currency(event['ShipmentItemList']),
      shipment_item_charge_adjustment_total: self.shipment_item_charge_total(event['ShipmentItemList'], 'ItemChargeAdjustmentList'),
      shipment_item_charge_adjustment_currency_code: self.shipment_item_charge_currency(event['ShipmentItemList'], event['ItemChargeAdjustmentList']),
      shipment_item_fee_total: self.shipment_item_fee_total(event['ShipmentItemList'], 'ItemFeeList'),
      shipment_item_fee_currency_code: self.shipment_item_fee_currency(event['ShipmentItemList'], 'ItemFeeList'),
      shipment_item_fee_adjustment_total: self.shipment_item_fee_total(event['ShipmentItemList'], 'ItemFeeAdjustmentList'),
      shipment_item_fee_adjustment_currency_code: self.shipment_item_fee_currency(event['ShipmentItemList'], 'ItemFeeAdjustmentList'),
      shipment_item_promotion_total: self.shipment_item_promotion_total(event['ShipmentItemList'], 'PromotionList'),
      shipment_item_promotion_currency_code: self.shipment_item_promotion_currency(event['ShipmentItemList'], 'PromotionList'),
      shipment_item_promotion_adjustment_total: self.shipment_item_promotion_total(event['ShipmentItemList'], 'PromotionAdjustmentList'),
      shipment_item_promotion_adjustment_currency_code: self.shipment_item_promotion_currency(event['ShipmentItemList'], 'PromotionAdjustmentList'),
      shipment_item_points_granted_total: self.shipment_item_subkey_total(event['ShipmentItemList'], 'CostOfPointsGranted'),
      shipment_item_points_granted_currency_code: self.shipment_item_subkey_total(event['ShipmentItemList'], 'CostOfPointsGranted'),
      shipment_item_points_returned_total: self.shipment_item_subkey_total(event['ShipmentItemList'], 'CostOfPointsReturned'),
      shipment_item_points_returned_currency_code: self.shipment_item_subkey_total(event['ShipmentItemList'], 'CostOfPointsReturned'),
      shipment_item_adjustment_skus: self.shipment_item_skus(event['ShipmentItemAdjustmentList']),
      shipment_item_adjustment_charge_total: self.shipment_item_charge_total(event['ShipmentItemAdjustmentList'], 'ItemChargeList'),
      shipment_item_adjustment_charge_currency_code: self.shipment_item_charge_currency(event['ShipmentItemAdjustmentList'], 'ItemChargeList'),
      shipment_item_adjustment_tax_withheld_total: self.shipment_tax_withheld_total(event['ShipmentItemAdjustmentList']),
      shipment_item_adjustment_tax_withheld_currency_code: self.shipment_tax_withheld_currency(event['ShipmentItemAdjustmentList']),
      shipment_item_adjustment_charge_adjustment_total: self.shipment_item_charge_total(event['ShipmentItemAdjustmentList'], 'ItemChargeAdjustmentList'),
      shipment_item_adjustment_charge_adjustment_currency_code: self.shipment_item_charge_currency(event['ShipmentItemAdjustmentList'], event['ItemChargeAdjustmentList']),
      shipment_item_adjustment_fee_total: self.shipment_item_fee_total(event['ShipmentItemAdjustmentList'], 'ItemFeeList'),
      shipment_item_adjustment_fee_currency_code: self.shipment_item_fee_currency(event['ShipmentItemAdjustmentList'], 'ItemFeeList'),
      shipment_item_adjustment_fee_adjustment_total: self.shipment_item_fee_total(event['ShipmentItemAdjustmentList'], 'ItemFeeAdjustmentList'),
      shipment_item_adjustment_fee_adjustment_currency_code: self.shipment_item_fee_currency(event['ShipmentItemAdjustmentList'], 'ItemFeeAdjustmentList'),
      shipment_item_adjustment_promotion_total: self.shipment_item_promotion_total(event['ShipmentItemAdjustmentList'], 'PromotionList'),
      shipment_item_adjustment_promotion_currency_code: self.shipment_item_promotion_currency(event['ShipmentItemAdjustmentList'], 'PromotionList'),
      shipment_item_adjustment_promotion_adjustment_total: self.shipment_item_promotion_total(event['ShipmentItemAdjustmentList'], 'PromotionAdjustmentList'),
      shipment_item_adjustment_promotion_adjustment_currency_code: self.shipment_item_promotion_currency(event['ShipmentItemAdjustmentList'], 'PromotionAdjustmentList'),
      shipment_item_adjustment_points_granted_total: self.shipment_item_subkey_total(event['ShipmentItemAdjustmentList'], 'CostOfPointsGranted'),
      shipment_item_adjustment_points_granted_currency_code: self.shipment_item_subkey_total(event['ShipmentItemAdjustmentList'], 'CostOfPointsGranted'),
      shipment_item_adjustment_points_returned_total: self.shipment_item_subkey_total(event['ShipmentItemAdjustmentList'], 'CostOfPointsReturned'),
      shipment_item_adjustment_points_returned_currency_code: self.shipment_item_subkey_total(event['ShipmentItemAdjustmentList'], 'CostOfPointsReturned'),
      company_id: company_id,
      event_day: event_day
		)
	end

  def self.shipment_item_skus(shipment_item_list)
    shipment_item_skus = []
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        shipment_item_skus << shipment_item_list['ShipmentItem']['SellerSKU']
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        shipment_item_list['ShipmentItem'].each{|i| shipment_item_skus << i['SellerSKU']}
      end
    end
    shipment_item_skus.join(',')
  end

  def self.shipment_item_charge_total(shipment_item_list, list_key)
    shipment_item_charge_total = 0
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        shipment_item_charge_total = self.charge_component_total(shipment_item_list['ShipmentItem'][list_key])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        shipment_item_list['ShipmentItem'].each{|i| shipment_item_charge_total += self.charge_component_total(i[list_key])}
      end
    end
    shipment_item_charge_total
  end

  def self.shipment_item_charge_currency(shipment_item_list, list_key)
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        self.charge_component_currency(shipment_item_list['ShipmentItem'][list_key])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        self.charge_component_currency(shipment_item_list['ShipmentItem'].first[list_key])
      else
        nil
      end
    else
      nil
    end
  end

  def self.shipment_item_fee_total(shipment_item_list, list_key)
    shipment_item_fee_total = 0
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        shipment_item_fee_total = self.fee_component_total(shipment_item_list['ShipmentItem'][list_key])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        shipment_item_list['ShipmentItem'].each{|i| shipment_item_fee_total += self.fee_component_total(i[list_key])}
      end
    end
    shipment_item_fee_total
  end

  def self.shipment_item_fee_currency(shipment_item_list, list_key)
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        self.fee_component_currency(shipment_item_list['ShipmentItem'][list_key])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        self.fee_component_currency(shipment_item_list['ShipmentItem'].first[list_key])
      else
        nil
      end
    else
      nil
    end
  end

  def self.shipment_item_promotion_total(shipment_item_list, list_key)
    shipment_item_promotion_total = 0
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        shipment_item_promotion_total = self.promotion_total(shipment_item_list['ShipmentItem'][list_key])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        shipment_item_list['ShipmentItem'].each{|i| shipment_item_promotion_total += self.promotion_total(i[list_key])}
      end
    end
    shipment_item_promotion_total
  end

  def self.shipment_item_promotion_currency(shipment_item_list, list_key)
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        self.promotion_currency(shipment_item_list['ShipmentItem'][list_key])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        self.promotion_currency(shipment_item_list['ShipmentItem'].first[list_key])
      else
        nil
      end
    else
      nil
    end
  end

  def self.shipment_tax_withheld_total(shipment_item_list)
    shipment_tax_withheld_total = 0
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        self.tax_withheld_total(shipment_item_list['ShipmentItem']['ItemTaxWithheldList'])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        shipment_item_list['ShipmentItem'].each{|i| shipment_tax_withheld_total += self.tax_withheld_total(i['ItemTaxWithheldList'])}
      end
    end
    shipment_tax_withheld_total
  end

  def self.shipment_tax_withheld_currency(shipment_item_list)
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        self.tax_withheld_currency(shipment_item_list['ShipmentItem']['ItemTaxWithheldList'])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        self.tax_withheld_currency(shipment_item_list['ShipmentItem'].first['ItemTaxWithheldList'])
      else
        nil
      end
    else
      nil
    end
  end

  def self.shipment_item_subkey_total(shipment_item_list, subkey)
    shipment_item_subkey_total = 0
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        self.currency_amount(shipment_item_list['ShipmentItem'][subkey])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        shipment_item_list['ShipmentItem'].each{|i| shipment_item_subkey_total += self.currency_amount(i[subkey])}
      end
    end
    shipment_item_subkey_total
  end

  def self.shipment_item_subkey_currency(shipment_item_list, subkey)
    if shipment_item_list
      if shipment_item_list['ShipmentItem'].is_a? Hash
        self.currency_code(shipment_item_list['ShipmentItem'][subkey])
      elsif shipment_item_list['ShipmentItem'].is_a? Array
        self.currency_code(shipment_item_list['ShipmentItem'].first[subkey])
      else
        nil
      end
    else
      nil
    end
  end
end
