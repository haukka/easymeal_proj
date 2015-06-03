# -*- encoding : utf-8 -*-
class CreateJoinTableMenuScheduleRecipe < ActiveRecord::Migration
  def change
    create_join_table :menu_schedules, :recipes do |t|
      # t.index [:menu_schedule_id, :recipe_id]
      # t.index [:recipe_id, :menu_schedule_id]
    end
  end
end
