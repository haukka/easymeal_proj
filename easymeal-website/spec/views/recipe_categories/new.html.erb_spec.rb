require 'spec_helper'

describe "recipe_categories/new" do
  before(:each) do
    assign(:recipe_category, stub_model(RecipeCategory).as_new_record)
  end

  it "renders new recipe_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recipe_categories_path, "post" do
    end
  end
end
