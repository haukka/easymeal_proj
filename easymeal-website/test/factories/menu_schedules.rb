# == Schema Information
#
# Table name: menu_schedules
#
#  id         :integer          not null, primary key
#  weekNumber :integer
#  year       :integer
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  day        :integer
#  meal       :integer
#

FactoryGirl.define do
  factory :menu_schedule do
    weekNumber 1
    year 2014
    day 7
    meal 2
  end
end
