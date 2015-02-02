class IndexController < ApplicationController

	def index
		puts params[:from]
		q = params[:from] ? params : { :from => "USD", :to => "BRL",  :date_start => "2014-01-01", :date_end => "2015-01-01" }
		@quotes = Jsonrates::Client.historical(q)

		@times = @quotes.collect { |v| v[1]["utctime"] }
		@rates = @quotes.collect { |v| v[1]["rate"] }

		@data_points = @quotes.inject({}) { |h,v| h.merge( v[1]["utctime"] => v[1]["rate"] ) }

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
		  f.title(:text => "From #{params[:from]} to #{params[:to]}")
		  f.series(:name => "GDP in Billions", :yAxis => 0, :data => @data_points )

		  f.yAxis [
		    {:title => {:text => "GDP in Billions", :margin => 70} },
		    {:title => {:text => "Population in Millions"}, :opposite => true},
		  ]

		end

		@msg = 'testttt'
		render :action => "index"
	end	
end
