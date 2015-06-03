# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: menu_schedules
#
#  id         :integer          not null, primary key
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  meal       :integer
#  date       :date
#

FactoryGirl.define do
  factory :menu_schedule do
    home_id 1
    meal 0
    date "2014-12-03"
  end
end
