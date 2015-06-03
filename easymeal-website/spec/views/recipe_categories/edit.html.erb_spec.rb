require 'spec_helper'

describe "recipe_categories/edit" do
  before(:each) do
    @recipe_category = assign(:recipe_category, stub_model(RecipeCategory))
  end

  it "renders the edit recipe_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recipe_category_path(@recipe_category), "post" do
    end
  end
end
