# == Schema Information
#
# Table name: moderates
#
#  id         :integer          not null, primary key
#  disease_id :integer
#  aliment_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :moderate do
    disease_id 1
    aliment_id 1
  end
end
