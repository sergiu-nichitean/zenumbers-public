class AmazonFinancialEvent < ApplicationRecord
	belongs_to :company

  # input from Amazon

	def self.fetch_from_amazon
  	Company.all.each do |company|
      # TODO: comment out 'true'
  		if true || company.amazon_financial_events.empty? || company.amazon_financial_events.where('created_at > ?', 24.hours.ago).count == 0
        puts "Company with ID #{company.id} doesn't have recorded financial events in the last 24 hours, fetching orders."
        client = MWS.finances(marketplace: company.marketplace,
                        merchant_id: company.merchant_id,
                        auth_token: company.mws_auth_token,
                        aws_access_key_id: Rails.configuration.mws['aws_access_key_id'],
                        aws_secret_access_key: Rails.configuration.mws['aws_secret_access_key'])
        self.get_daily_financial_events(client, company)
      else
        puts "Company with ID #{company.id} has recorded finances in the last 24 hours, skipping."
      end
  	end
  end

  def self.get_daily_financial_events(client, company)
    if company.amazon_financial_events.empty?
      events_start_date = Date.parse(6.months.ago.strftime("%Y-%m-01"))
    else
      # TODO: delete events from last day and refresh them (maybe the day is incomplete because of an error)
      events_start_date = company.amazon_financial_events.order(event_day: :desc).first.event_day + 1.day
    end

    yesterday = 1.day.ago.to_date

    events_start_date.upto(yesterday) do |date|
      events = self.get_events_for_specific_date(client, company, date)
      self.process_events(events, company, date)

      if events['NextToken']
        self.get_events_by_next_token(client, company, date, events['NextToken'])
      end
    end
  end

  def self.get_events_by_next_token(client, company, date, token)
    events = self.get_events_for_specific_token(client, company, token)
    self.process_events(events, company, date)

    if events['NextToken']
      self.get_events_by_next_token(client, company, date, events['NextToken'])
    end
  end

  def self.get_events_for_specific_date(client, company, date, delay = 0)
    puts "Fetching finances for: #{date.iso8601}"
    puts "Sleeping for 3 seconds before making finances call"
    sleep(3)
    client.list_financial_events(posted_after: date.iso8601, posted_before: (date + 1.day).iso8601).parse
  rescue Peddler::Errors::RequestThrottled
    puts "Request throttled, sleeping for #{delay + 1} minutes before making finances call"
    sleep((delay + 1).minutes)
    self.get_events_for_specific_date(client, company, date, delay + 1)
  end

  def self.get_events_for_specific_token(client, company, token, delay = 0)
    puts "Fetching finances with next token: #{token}"
    puts "Sleeping for 3 seconds before making finances call"
    sleep(3)
    client.list_financial_events_by_next_token(token).parse
  rescue
    puts "Request throttled, sleeping for #{delay + 1} minutes before making finances call"
    sleep((delay + 1).minutes)
    self.get_events_for_specific_token(client, company, token, delay + 1)
  end

  def self.process_events(events, company, date)
    event_types = events['FinancialEvents']
    event_types.keys.each do |event_type| 
      unless event_types[event_type].nil?
        clean_event_type = event_type.gsub('List', '')
        events_of_type = event_types[event_type][clean_event_type]

        if events_of_type.nil?
          events_of_type = event_types[event_type]['ShipmentEvent']
        end

        puts "Fetching a #{clean_event_type}"

        if events_of_type.is_a? Array
          events_of_type.each do |event|
            eval(clean_event_type).parse_and_create(event, company.id, date)
          end
        elsif events_of_type.is_a? Hash
          eval(clean_event_type).parse_and_create(events_of_type, company.id, date)
        end
      end
    end
  end

  def self.charge_component_total(charge_list)
    charge_total = 0
    if charge_list
      if charge_list['ChargeComponent'].is_a? Hash
        charge_total = charge_list['ChargeComponent']['ChargeAmount']['CurrencyAmount'].to_f
      elsif charge_list['ChargeComponent'].is_a? Array
        charge_list['ChargeComponent'].each{|c| charge_total += c['ChargeAmount']['CurrencyAmount'].to_f}
      end
    end
    charge_total
  end

  def self.charge_component_currency(charge_list)
    if charge_list
      if charge_list['ChargeComponent'].is_a? Hash
        charge_list['ChargeComponent']['ChargeAmount']['CurrencyCode']
      elsif charge_list['ChargeComponent'].is_a? Array
        charge_list['ChargeComponent'].first['ChargeAmount']['CurrencyCode']
      else
        nil
      end
    else
      nil
    end
  end

  def self.fee_component_total(fee_list)
    fee_total = 0
    if fee_list
      if fee_list['FeeComponent'].is_a? Hash
        fee_total = fee_list['FeeComponent']['FeeAmount']['CurrencyAmount'].to_f
      elsif fee_list['FeeComponent'].is_a? Array
        fee_list['FeeComponent'].each{|c| fee_total += c['FeeAmount']['CurrencyAmount'].to_f}
      end
    end
    fee_total
  end

  def self.fee_component_currency(fee_list)
    if fee_list
      if fee_list['FeeComponent'].is_a? Hash
        fee_list['FeeComponent']['FeeAmount']['CurrencyCode']
      elsif fee_list['FeeComponent'].is_a? Array
        fee_list['FeeComponent'].first['FeeAmount']['CurrencyCode']
      else
        nil
      end
    else
      nil
    end
  end

  def self.promotion_total(promotion_list)
    promotion_total = 0
    if promotion_list
      if promotion_list['Promotion'].is_a? Hash
        promotion_total = promotion_list['Promotion']['PromotionAmount']['CurrencyAmount'].to_f
      elsif promotion_list['Promotion'].is_a? Array
        promotion_list['Promotion'].each{|pr| promotion_total += pr['PromotionAmount']['CurrencyAmount'].to_f}
      end
    end
    promotion_total
  end

  def self.promotion_currency(fee_list)
    if fee_list
      if fee_list['Promotion'].is_a? Hash
        fee_list['Promotion']['PromotionAmount']['CurrencyCode']
      elsif fee_list['Promotion'].is_a? Array
        fee_list['Promotion'].first['PromotionAmount']['CurrencyCode']
      else
        nil
      end
    else
      nil
    end
  end

  def self.direct_payment_total(direct_payment_list)
    direct_payment_total = 0
    if direct_payment_list
      if direct_payment_list['DirectPayment'].is_a? Hash
        direct_payment_total = direct_payment_list['DirectPayment']['DirectPaymentAmount']['CurrencyAmount'].to_f
      elsif direct_payment_list['DirectPayment'].is_a? Array
        direct_payment_list['DirectPayment'].each{|c| direct_payment_total += c['DirectPaymentAmount']['CurrencyAmount'].to_f}
      end
    end
    direct_payment_total
  end

  def self.direct_payment_currency(direct_payment_list)
    if direct_payment_list
      if direct_payment_list['DirectPayment'].is_a? Hash
        direct_payment_list['DirectPayment']['DirectPaymentAmount']['CurrencyCode']
      elsif direct_payment_list['DirectPayment'].is_a? Array
        direct_payment_list['DirectPayment'].first['DirectPaymentAmount']['CurrencyCode']
      else
        nil
      end
    else
      nil
    end
  end

  def self.tax_withheld_total(tax_withheld_list)
    tax_withheld_total = 0
    if tax_withheld_list
      if tax_withheld_list['TaxWithheldComponent'].is_a? Hash
        tax_withheld_total = self.charge_component_total(tax_withheld_list['TaxWithheldComponent']['TaxesWithheld'])
      elsif tax_withheld_list['TaxWithheldComponent'].is_a? Array
        tax_withheld_list['TaxWithheldComponent'].each{|t| tax_withheld_total += self.charge_component_total(t['TaxesWithheld'])}
      end
    end
    tax_withheld_total
  end

  def self.tax_withheld_currency(tax_withheld_list)
    if tax_withheld_list
      if tax_withheld_list['TaxWithheldComponent'].is_a? Hash
        self.charge_component_currency(tax_withheld_list['TaxWithheldComponent']['TaxesWithheld'])
      elsif tax_withheld_list['TaxWithheldComponent'].is_a? Array
        self.charge_component_currency(tax_withheld_list['TaxWithheldComponent'].first['TaxesWithheld'])
      else
        nil
      end
    else
      nil
    end
  end

  def self.currency_amount(currency_amount)
    currency_amount ? currency_amount['CurrencyAmount'] : 0
  end

  def self.currency_code(currency_amount)
    currency_amount ? currency_amount['CurrencyCode'] : nil
  end

  # Output into platform

  def self.get_sales_proceeds(company_id, start_date, end_date)
    ShipmentEvent.where('company_id = ? AND event_day BETWEEN ? AND ?', company_id, start_date, end_date).all.sum{|e| e.shipment_item_charge_total}
  end

  def self.get_refund_adjustments(company_id, start_date, end_date)
    RefundEvent.where('company_id = ? AND event_day BETWEEN ? AND ?', company_id, start_date, end_date).all.sum{|e| e.shipment_item_adjustment_fee_adjustment_total + e.shipment_item_adjustment_promotion_adjustment_total}
  end

  def self.get_other_adjustments(company_id, start_date, end_date)
    AdjustmentEvent.where('company_id = ? AND event_day BETWEEN ? AND ?', company_id, start_date, end_date).all.sum{|e| e.adjustment_amount_currency_amount}
  end

  def self.get_total_fees(company_id, start_date, end_date)
    ShipmentEvent.where('company_id = ? AND event_day BETWEEN ? AND ?', company_id, start_date, end_date).all.sum{|e| e.shipment_item_fee_total}
  end

  def self.get_refunds_total(company_id, start_date, end_date)
    RefundEvent.where('company_id = ? AND event_day BETWEEN ? AND ?', company_id, start_date, end_date).all.sum{|e| e.shipment_item_adjustment_charge_adjustment_total}
  end

  def self.get_promotions_total(company_id, start_date, end_date)
    ShipmentEvent.where('company_id = ? AND event_day BETWEEN ? AND ?', company_id, start_date, end_date).all.sum{|e| e.shipment_item_promotion_total}
  end

  def self.get_ppc_cost(company_id, start_date, end_date)
    ProductAdsPaymentEvent.where('company_id = ? AND event_day BETWEEN ? AND ?', company_id, start_date, end_date).all.sum{|e| e.transaction_value_currency_amount}
  end

  def self.get_service_fees(company_id, start_date, end_date)
    ServiceFeeEvent.where('company_id = ? AND event_day BETWEEN ? AND ?', company_id, start_date, end_date).all.sum{|e| e.fee_total}
  end

  def self.get_other_expenses(company_id, start_date, end_date)
    # TODO: maybe add all other negative balance event types?
    0
  end

end
