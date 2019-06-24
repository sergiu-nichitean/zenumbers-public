class DashboardController < ApplicationController

	def monthly_cashflow
		start_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
		end_date = Date.new(params[:year].to_i, params[:month].to_i, -1)

		@revenues = [
			{
				name: 'Sales Proceeds',
				amount: AmazonFinancialEvent.get_sales_proceeds(@company.id, start_date, end_date)
			},
			{
				name: 'Refund Adjustments',
				amount: AmazonFinancialEvent.get_refund_adjustments(@company.id, start_date, end_date)
			},
			{
				name: 'Other Adjustments',
				amount: AmazonFinancialEvent.get_other_adjustments(@company.id, start_date, end_date)
			}
		]

		# TODO: add percent from revenue?
		@expenses = [
			{
				name: 'Production Costs',
				amount: Expense.total_product_expenses(@company, 'production', start_date, end_date)
			},
			{
				name: 'Ship to Amazon Costs',
				amount: Expense.total_product_expenses(@company, 'shipping', start_date, end_date)
			},
			{
				name: 'Referral & FBA Fees',
				amount: AmazonFinancialEvent.get_total_fees(@company.id, start_date, end_date)
			},
			{
				name: 'Refunds',
				amount: AmazonFinancialEvent.get_refunds_total(@company.id, start_date, end_date)
			},
			{
				name: 'Promotions',
				amount: AmazonFinancialEvent.get_promotions_total(@company.id, start_date, end_date)
			},
			{
				name: 'Advertising Cost',
				amount: AmazonFinancialEvent.get_ppc_cost(@company.id, start_date, end_date)
			},
			{
				name: 'Service Fees',
				amount: AmazonFinancialEvent.get_service_fees(@company.id, start_date, end_date)
			},
			{
				name: 'Other Expenses',
				amount: AmazonFinancialEvent.get_other_expenses(@company.id, start_date, end_date)
			}
		]

		@total_revenues = @revenues.sum{|r| r[:amount]}
		@total_expenses = @expenses.sum{|e| e[:amount]}
		@total_profit = @total_revenues + @total_expenses
		@net_profit_margin = (@total_profit * 100) / @total_revenues
		@total_acos = ((-@expenses[5][:amount]) * 100) / @revenues[0][:amount]
		@brutto_profit_margin = ((@total_revenues + @expenses[0][:amount] + @expenses[1][:amount]) * 100) / @total_revenues
	end

	def all_orders
		orders = AmazonOrder.where('buyer_name is not null AND order_total_amount > 60')
		content = ''
		orders.each do |o|
			name_array = o.buyer_name.split(' ')
			first_name = name_array[0]
			name_array.shift
			last_name = name_array.join(' ')
			content << "#{first_name}\t#{last_name}\t#{o.shipping_address_postal_code}\t#{o.shipping_address_city}\t#{o.shipping_address_state_or_region}\t#{o.shipping_address_country_code}\n"
		end
		render plain: content
	end

end