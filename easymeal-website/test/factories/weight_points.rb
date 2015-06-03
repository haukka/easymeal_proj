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

FactoryGirl.define do
  factory :weight_point do
    weight 42
    date 2014-05-03
  end
end
