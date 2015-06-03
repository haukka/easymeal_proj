require 'spec_helper'

describe "recipe_categories/show" do
  before(:each) do
    @recipe_category = assign(:recipe_category, stub_model(RecipeCategory))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
