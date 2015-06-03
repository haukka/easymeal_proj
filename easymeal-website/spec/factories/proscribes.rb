# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: proscribes
#
#  id         :integer          not null, primary key
#  disease_id :integer
#  aliment_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :proscribe do
    disease_id 1
    aliments_id 1
  end
end
