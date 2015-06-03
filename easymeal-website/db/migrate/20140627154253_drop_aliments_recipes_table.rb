# -*- encoding : utf-8 -*-
class DropAlimentsRecipesTable < ActiveRecord::Migration
  def up
    drop_table :aliments_recipes
  end
  
  def down
    create_table :aliments_recipes do |t|
      t.belongs_to :aliments
      t.belongs_to :recipes
    end
  end
end
