class AddDayAndMealToMenuSchedule < ActiveRecord::Migration
  def up
    add_column :menu_schedules, :day, :integer
    add_column :menu_schedules, :meal, :integer
  end
  
  def down
    remove_column :menu_schedules, :day
    remove_column :menu_schedules, :meal
  end
end
