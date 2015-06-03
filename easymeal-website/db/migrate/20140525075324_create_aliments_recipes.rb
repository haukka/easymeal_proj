# -*- encoding : utf-8 -*-
class CreateAlimentsRecipes < ActiveRecord::Migration
  def change
    create_table :aliments_recipes do |t|
      t.belongs_to :aliments
      t.belongs_to :recipes
    end
  end
end
