json.extract! amazon_order, :id, :amz_id, :purchase_date, :payments_date, :buyer_email, :buyer_name, :buyer_phone_number, :company_id, :created_at, :updated_at
json.url amazon_order_url(amazon_order, format: :json)
