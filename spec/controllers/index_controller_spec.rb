require "rails_helper"

RSpec.describe IndexController, :type => :controller do
  describe "GET #index without params" do
    it "redirects to default params" do
      get :index
      expect(response).to redirect_to root_path(:from => "USD", 
                                                :to => "BRL", 
                                                :date_start => "2014-01-01", 
                                                :date_end => "2015-01-01") 
    end
  end

  describe "test get_data_points" do
    it "returns an array to rates" do

      q = [:from => "USD", 
            :to => "BRL", 
            :date_start => "2014-01-01", 
            :date_end => "2015-01-01"]

      out = [1.4,2.3,3.2]      

      allow(Jsonrates::Client).to receive(:historical).and_return(out)

      controller.send(:get_data_points?).should eql([1.4,2.3,3.2])

    end
  end  
end