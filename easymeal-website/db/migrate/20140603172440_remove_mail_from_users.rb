# -*- encoding : utf-8 -*-
class RemoveMailFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :mail
  end
  
  def down
    add_column :users, :mail, :string
  end
end
