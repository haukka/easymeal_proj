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
    @diet = FactoryGirl.create(:diet_type, name: 'stabilization')
    @user = FactoryGirl.create(:user);
  end

  test "home is valid" do
    home = FactoryGirl.build(:home, householder_id: @user.id)
    assert home.valid?
  end

  test "home invalid" do
    home = FactoryGirl.build(:home, householder_id: nil)
    assert !home.valid?, "must have a housholder"
  end

  test "home valid without a street" do
    home = FactoryGirl.build(:home, householder_id: @user.id, street: nil)
    assert home.valid?, "home should be valid without a street"
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
