class IndexController < ApplicationController

	def index
		
		@data_points = get_data_points(params)

		@msg = 'testttt'
		render :action => "index"
	end	

	private
	def get_data_points(params)
		q = params[:from] ? params : { :from => "USD", :to => "BRL",  :date_start => "2014-01-01", :date_end => "2015-01-01" }
		@quotes = Jsonrates::Client.historical(q)

		@quotes.inject({}) { |h,v| h.merge( v[1]["utctime"] => v[1]["rate"] ) }.to_json
	end	
end
