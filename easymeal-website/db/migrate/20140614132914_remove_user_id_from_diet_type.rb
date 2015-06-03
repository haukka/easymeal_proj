class RemoveUserIdFromDietType < ActiveRecord::Migration
  def change
    remove_column :diet_types, :user_id, :integer
  end
end
