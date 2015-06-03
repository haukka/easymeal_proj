require "spec_helper"

describe RecipeCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/recipe_categories").should route_to("recipe_categories#index")
    end

    it "routes to #new" do
      get("/recipe_categories/new").should route_to("recipe_categories#new")
    end

    it "routes to #show" do
      get("/recipe_categories/1").should route_to("recipe_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recipe_categories/1/edit").should route_to("recipe_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recipe_categories").should route_to("recipe_categories#create")
    end

    it "routes to #update" do
      put("/recipe_categories/1").should route_to("recipe_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recipe_categories/1").should route_to("recipe_categories#destroy", :id => "1")
    end

  end
end
