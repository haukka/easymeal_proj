# -*- encoding : utf-8 -*-
class AddZipcodeToHome < ActiveRecord::Migration
  def up
    add_column :homes, :zipcode, :string
  end
  
  def down
    remove_column :homes, :zipcode
  end
end
