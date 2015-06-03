# -*- encoding : utf-8 -*-
class AddNameToRecipes < ActiveRecord::Migration
  def up
    add_column :recipes, :name, :string
  end
  
  def down
    remove_column :recipes, :name
  end
end
