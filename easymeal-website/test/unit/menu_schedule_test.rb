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

require 'test_helper'

class MenuScheduleTest < ActiveSupport::TestCase
  
  def setup
    @home = FactoryGirl.create(:home)
  end

  test "menu_schedule is valid" do
    menu_schedules = FactoryGirl.build(:menu_schedule, home: @home)
    assert menu_schedules.valid?
  end

  test "menu_schedule invalid without a home" do
    menu_schedules = FactoryGirl.build(:menu_schedule, home: nil)
    assert !menu_schedules.valid?, "a menu_schedule must have a home"
  end

  test "menu_schedule invalid without a week" do
    menu_schedules = FactoryGirl.build(:menu_schedule, home: @home, weekNumber: nil)
    assert !menu_schedules.valid?, "a menu_schedule must have a week"
  end

  test "menu_schedule invalid without a year" do
    menu_schedules = FactoryGirl.build(:menu_schedule, home: @home, year: nil)
    assert !menu_schedules.valid?, "a menu_schedule must have a year"
  end  

  test "menu_schedule invalid without a meal" do
    menu_schedules = FactoryGirl.build(:menu_schedule, home: @home, meal: nil)
    assert !menu_schedules.valid?, "a menu_schedule must have a meal"
  end

  test "menu_schedule invalid without a day" do
    menu_schedules = FactoryGirl.build(:menu_schedule, home: @home, day: nil)
    assert !menu_schedules.valid?, "a menu_schedule must have a day"
  end
end
