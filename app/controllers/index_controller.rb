class IndexController < ApplicationController

	def index
		puts params[:from]
		q = params[:from] ? params : { :from => "USD", :to => "BRL",  :date_start => "2014-01-01", :date_end => "2015-01-01" }
		@quotes = Jsonrates::Client.historical(q)

		@msg = 'testttt'
		render :action => "index"
	end	
end
