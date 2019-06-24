class ChangeCompanies < ActiveRecord::Migration[5.2]
  def change
  	remove_column :companies, :aws_secret_access_key
  end
end
