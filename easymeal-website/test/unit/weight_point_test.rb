# == Schema Information
#
# Table name: weight_points
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  weight     :integer
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class WeightPointTest < ActiveSupport::TestCase

  def setup
    diet = FactoryGirl.create(:diet_type, name: 'stabilization')
    @user = FactoryGirl.create(:user)
  end

  test "weightPoint is valid" do
    weight_point = FactoryGirl.build(:weight_point, user:@user)
    assert weight_point.valid?
  end

  test "weightPoint invalid without weight" do
    weight_point = FactoryGirl.build(:weight_point, weight: nil, user:@user)
    assert !weight_point.valid?, "weightPoint must have a weight"
  end

  test "weightPoint invalid without a user" do
    weight_point = FactoryGirl.build(:weight_point, user: nil)
    assert !weight_point.valid?, "weightPoint must have a weight"
  end

  test "weightPoint invalid without a date" do
    weight_point = FactoryGirl.build(:weight_point, user: @user, date: nil)
    assert !weight_point.valid?, "weightPoint must have  a date"
  end
end
