# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  text       :text
#  time       :integer
#  difficulty :integer
#  calories   :integer
#  price      :float
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
	def setup
    @category = FactoryGirl.create(:category)
    @blue_cheese = FactoryGirl.create(:aliment, categories: [@category])
    @sour_cream = FactoryGirl.create(:aliment, name:"sour cream", categories: [@category])
	end
  
  test "recipe is valid" do
    recipes = FactoryGirl.build(:recipe, aliments: [@blue_cheese, @sour_cream], name: "Blue sauce")
    assert recipes.valid?
  end
  
  test "recipe invalid without aliments" do
    recipes = FactoryGirl.build(:recipe, aliments: [])
    assert !recipes.valid?, "A recipe must have at least one aliment."
  end
  
  test "recipe invalid without name" do
    recipes = FactoryGirl.build(:recipe, name: nil)
    assert !recipes.valid?, "A recipe must have a name."
  end
  
  test "recipe invalid without time" do
    recipes = FactoryGirl.build(:recipe, time: nil)
    assert !recipes.valid?, "A recipe must have a time."
  end
  
  test "recipe invalid without difficulty" do
    recipes = FactoryGirl.build(:recipe, difficulty: nil)
    assert !recipes.valid?, "A recipe must have a name."
  end
  
  test "recipe invalid without price" do
    recipes = FactoryGirl.build(:recipe, price: nil)
    assert !recipes.valid?, "A recipe must have a price."
  end
  
  test "recipe invalid without text" do
    recipes = FactoryGirl.build(:recipe, text: nil)
    assert !recipes.valid?, "A recipe must have a text."
  end
  
end
