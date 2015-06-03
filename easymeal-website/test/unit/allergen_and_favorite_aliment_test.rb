# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: allergen_and_favorite_aliments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  aliment_id :integer
#  allergy    :boolean
#  created_at :datetime
#  updated_at :datetime
#  favori     :boolean
#

require 'test_helper'

class AllergenAndFavoriteAlimentTest < ActiveSupport::TestCase
  
	def setup
          @diet = FactoryGirl.create(:diet_type, name: 'stabilization')
          @category = FactoryGirl.create(:category)
          @aliment = FactoryGirl.create(:aliment, categories: [@category])
          @user = FactoryGirl.create(:user)
	end
  
	test "allergenAndFavoriteAlimentTest is valid" do
          allergen_and_favorite_aliment = FactoryGirl.build(:allergen_and_favorite_aliment, aliment: @aliment, user: @user)
          assert allergen_and_favorite_aliment.valid?
	end
        
        test "allergenAndFavoriteAlimentTest invlid without a user" do
          allergen_and_favorite_aliment = FactoryGirl.build(:allergen_and_favorite_aliment, aliment: @aliment, user: nil)
          assert !allergen_and_favorite_aliment.valid?, "An allergen_and_favorite_aliment must have a user."
        end
  
        test "allergenAndFavoriteAlimentTest invlid without an aliment" do
          allergen_and_favorite_aliment = FactoryGirl.build(:allergen_and_favorite_aliment, aliment: nil, user: @user)
          assert !allergen_and_favorite_aliment.valid?, "An allergen_and_favorite_aliment must belongs_to an aliment."
        end
end
