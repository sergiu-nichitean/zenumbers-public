class AddAwsCredentialsToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :marketplace, :string
    add_column :companies, :merchant_id, :string
    add_column :companies, :aws_access_key_id, :string
    add_column :companies, :aws_secret_access_key, :string
  end
end
