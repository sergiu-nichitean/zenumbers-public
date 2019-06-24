class ApplicationController < ActionController::Base
	before_action :set_context

	def set_context
		# TODO: change to get from login session
		@company = Company.find(1)
		@global_currency = 'USD'
	end

end
