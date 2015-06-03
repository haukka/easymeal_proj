# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock do
    home_id 1
  end
end
