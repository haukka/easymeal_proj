# -*- encoding : utf-8 -*-
class RemoveHouseholderFromHome < ActiveRecord::Migration
  def up
    remove_column :homes, :householder
  end
  
  def down
    add_column :homes, :householder, :integer
  end
end
