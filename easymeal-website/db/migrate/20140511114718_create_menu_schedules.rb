# -*- encoding : utf-8 -*-
class CreateMenuSchedules < ActiveRecord::Migration
  def change
    create_table :menu_schedules do |t|
      t.integer :weekNumber
      t.integer :year
      t.integer :home_id

      t.timestamps
    end
  end
end
