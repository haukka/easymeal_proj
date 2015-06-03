# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: exceeds
#
#  id         :integer          not null, primary key
#  disease_id :integer
#  aliment_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exceed do
    disease_id 1
    aliment_id 1
  end
end
