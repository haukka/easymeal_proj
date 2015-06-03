# == Schema Information
#
# Table name: shopping_lists
#
#  id         :integer          not null, primary key
#  totalPrice :float
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ShoppingListTest < ActiveSupport::TestCase
  
	def setup
    @category = FactoryGirl.create(:category)
    @blue_cheese = FactoryGirl.create(:aliment, categories: [@category])
    @sour_cream = FactoryGirl.create(:aliment, name:"sour cream", categories: [@category])
    @home = FactoryGirl.create(:home)
	end
  
	test "shopping_list is valid" do
    aliment = FactoryGirl.build(:shopping_list, aliments: [@blue_cheese, @sour_cream], home: @home)
  	assert aliment.valid?
	end
  
	test "shopping_list invalid without home" do
    aliment = FactoryGirl.build(:shopping_list, aliments: [@blue_cheese, @sour_cream], home: nil)
  	assert !aliment.valid?, "A shopping list must have a home."
	end
  
end
