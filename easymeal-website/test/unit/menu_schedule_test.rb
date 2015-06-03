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

require 'test_helper'

class MenuScheduleTest < ActiveSupport::TestCase
  
  def setup
    @category = FactoryGirl.create(:category)
    @blue_cheese = FactoryGirl.create(:aliment, categories: [@category])
    @aliments_quantity = FactoryGirl.create(:aliments_quantity, aliment_id: @blue_cheese.id, quantity: 2)
    @recipe = FactoryGirl.build(:recipe, aliments_quantity: [@aliments_quantity], name: "Blue sauce")
    @diet = FactoryGirl.create(:diet_type, name: 'stabilization')
    @user = FactoryGirl.create(:user)
    @home = FactoryGirl.build(:home, householder_id:@user.id)
  end

  test "menu_schedule is valid" do
    menu_schedules = FactoryGirl.build(:menu_schedule, users: [@user], home: @home, date:"2014-12-03", meal: 0, recipes: [@recipe])
    assert menu_schedules.valid?
  end


  test "menu_schedule invalid without meal" do
    menu_schedules = FactoryGirl.build(:menu_schedule, users: [@user], home: @home, date:"2014-12-03", meal: nil, recipes: [@recipe])
    assert !menu_schedules.valid?, "a menu_schedule must have a meal"
  end

  test "menu_schedule invalid without date" do
    menu_schedules = FactoryGirl.build(:menu_schedule, users: [@user], home: @home, date: nil, meal: 0, recipes: [@recipe])
    assert !menu_schedules.valid?, "a menu_schedule must have a date"
  end

end
