# -*- encoding : utf-8 -*-
class AddHouseholderToHome < ActiveRecord::Migration
  def up
    add_column :homes, :householder_id, :integer
  end
  
  def down
    remove_column :homes, :householder_id
  end
end
