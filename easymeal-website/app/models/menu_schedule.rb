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

class MenuSchedule < ActiveRecord::Base
  
  module MEALS
    Breakfast = 0
    Lunch = 1
    Dinner = 2
  end
  
  belongs_to :home
  has_and_belongs_to_many :users
  has_and_belongs_to_many :recipes

  validates :date, presence: true
  validates :meal, presence: true

  
end
