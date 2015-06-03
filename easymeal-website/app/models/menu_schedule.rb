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

class MenuSchedule < ActiveRecord::Base
  belongs_to :home
  has_and_belongs_to_many :users

  validates :home, presence: true
  validates :day, presence: true
  validates :meal, presence: true
  validates :year, presence: true
  validates :weekNumber, presence: true
end
