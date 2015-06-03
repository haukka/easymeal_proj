# -*- encoding : utf-8 -*-
class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :text
      t.integer :time
      t.integer :difficulty
      t.integer :calories
      t.float :price

      t.timestamps
    end
  end
end
