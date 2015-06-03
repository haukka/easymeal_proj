class AddUserIdFromDietType < ActiveRecord::Migration
  def change
    add_column :diet_types, :user_id, :integer
  end
end
