# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: homes
#
#  id             :integer          not null, primary key
#  street         :string(255)
#  city           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  householder_id :integer
#  zipcode        :string(255)
#  name           :string(255)
#

require 'test_helper'

class HomeTest < ActiveSupport::TestCase
  
  def setup
    @category = FactoryGirl.create(:category)
    @blue_cheese = FactoryGirl.create(:aliment, categories: [@category])
    @aliments_quantity = FactoryGirl.create(:aliments_quantity, aliment_id: @blue_cheese.id, quantity: 2)
    @recipe = FactoryGirl.create(:recipe, aliments_quantity: [@aliments_quantity], name: "Blue sauce")
    @diet = FactoryGirl.create(:diet_type, name: 'stabilization')
    @user = FactoryGirl.create(:user);
  end

  test "home is valid" do
    home = FactoryGirl.build(:home, householder_id: @user.id, name: "test")
    assert home.valid?
  end

  test "home invalid without a householder" do
    home = FactoryGirl.build(:home, householder_id: nil)
    assert !home.valid?, "must have a housholder"
  end

  test "home valid without a street" do
    home = FactoryGirl.build(:home, householder_id: @user.id, street: nil)
    assert home.valid?, "home should be valid without a street"
  end

  test "home invalid without a name" do
    home = FactoryGirl.build(:home, householder_id: @user.id, name:nil)
    assert !home.valid?, "must have a name"
  end

  test "home invalid without a city" do
    home = FactoryGirl.build(:home, householder_id: @user.id, city: nil)
    assert !home.valid?, "must have a city"
  end

  test "home valid without a zipcode" do
    home = FactoryGirl.build(:home, householder_id: @user.id, zipcode: nil)
    assert home.valid?, "home should be valid without a zipcode"
  end
end
