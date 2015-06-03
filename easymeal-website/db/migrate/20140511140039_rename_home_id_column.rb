class RenameHomeIdColumn < ActiveRecord::Migration
  def change
    rename_column :users, :homeId, :home_id
  end
end
