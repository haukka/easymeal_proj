# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: shopping_lists
#
#  id         :integer          not null, primary key
#  totalPrice :float
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

require 'test_helper'

class ShoppingListTest < ActiveSupport::TestCase
  
	def setup
          @category = FactoryGirl.create(:category)
          @blue_cheese = FactoryGirl.create(:aliment, categories: [@category])
          @sour_cream = FactoryGirl.create(:aliment, name:"sour cream", categories: [@category])
          @diet = FactoryGirl.create(:diet_type, name: 'stabilization')
          @user = FactoryGirl.create(:user)
          @home = FactoryGirl.build(:home, householder_id:@user.id)
          @aliments_quantity = FactoryGirl.build(:aliments_quantity,  aliment_id: @blue_cheese.id, quantity: 2)
	end
  
	test "shopping_list is valid" do
          list = FactoryGirl.build(:shopping_list, aliments_quantity: [@aliments_quantity], home: @home, name: "toto")
          assert list.valid?
	end
  
        test "shopping_list valid without aliment" do
          list = FactoryGirl.build(:shopping_list, aliments_quantity: [], home: @home, name: "toto")
  	assert list.valid?
	end
        
	test "shopping_list invalid without home" do
          list = FactoryGirl.build(:shopping_list, aliments_quantity: [@aliments_quantity], home: nil, name: "toto")
  	assert !list.valid?, "A shopping list must have a home."
	end

	test "shopping_list invalid without name" do
          list = FactoryGirl.build(:shopping_list, aliments_quantity: [@aliments_quantity], home: @home, name: nil)
  	assert !list.valid?, "A shopping list must have a name."
	end
  
end
