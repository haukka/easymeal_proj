# -*- encoding : utf-8 -*-
class ChangeInfosToDateInMenuSchedule < ActiveRecord::Migration
  def change
    remove_column :menu_schedules, :weekNumber
    remove_column :menu_schedules, :year
    remove_column :menu_schedules, :day
    add_column :menu_schedules, :date, :date
  end
end
