# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: recipes
#
#  id                 :integer          not null, primary key
#  text               :text
#  time               :integer
#  difficulty         :integer
#  calories           :integer
#  price              :float
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string(255)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  recipe_day         :boolean          default(FALSE)
#  workflow_state     :string(255)
#

FactoryGirl.define do
  factory :recipe do
    text "test recipe"
    time 20
    difficulty 5
    calories 280
    price 2.0
  end
end
