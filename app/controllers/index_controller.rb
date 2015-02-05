class IndexController < ApplicationController

	def index
		
		unless params[:to]
			return redirect_to root_path(:from => "USD", 
								  :to => "BRL", 
								  :date_start => "2014-01-01", 
								  :date_end => "2015-01-01") 
		end

		@data_points = get_data_points(params)

		render :action => "index"
	end	

	private
	def get_data_points(q)
		@quotes = Jsonrates::Client.historical(q)

		@quotes.collect{ |v| v[1]["rate"].to_f }
	end	
end
