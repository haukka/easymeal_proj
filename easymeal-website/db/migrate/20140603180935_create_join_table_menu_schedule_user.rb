# -*- encoding : utf-8 -*-
class CreateJoinTableMenuScheduleUser < ActiveRecord::Migration
  def change
    create_join_table :menu_schedules, :users do |t|
      # t.index [:menu_schedule_id, :recipe_id]
      # t.index [:user_id, :menu_schedule_id]
    end
  end
end
