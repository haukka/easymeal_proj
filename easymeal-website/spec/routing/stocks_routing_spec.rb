# -*- encoding : utf-8 -*-
require "spec_helper"

describe StocksController do
  describe "routing" do

    it "routes to #index" do
      get("/stocks").should route_to("stocks#index")
    end

    it "routes to #new" do
      get("/stocks/new").should route_to("stocks#new")
    end

    it "routes to #show" do
      get("/stocks/1").should route_to("stocks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stocks/1/edit").should route_to("stocks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stocks").should route_to("stocks#create")
    end

    it "routes to #update" do
      put("/stocks/1").should route_to("stocks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stocks/1").should route_to("stocks#destroy", :id => "1")
    end

  end
end
