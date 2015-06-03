class CreateMenuSchedulesUsers < ActiveRecord::Migration
  def change
    create_table :menu_schedules_users do |t|
      t.belongs_to :user
      t.belongs_to :menu_schedule
    end
  end
end
