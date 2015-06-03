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

FactoryGirl.define do
  factory :stocks do
    home_id 1
    name "toto"
  end
end
