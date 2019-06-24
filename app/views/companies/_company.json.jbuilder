json.extract! company, :id, :name, :address, :city, :state, :zip, :country, :created_at, :updated_at
json.url company_url(company, format: :json)
