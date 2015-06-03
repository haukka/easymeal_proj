# -*- encoding : utf-8 -*-
class AddVitaminsBToAliment < ActiveRecord::Migration
  def up
    add_column :aliments, :vitaminB2, :float
    add_column :aliments, :vitaminB3, :float
    add_column :aliments, :vitaminB5, :float
    add_column :aliments, :vitaminB6, :float
    add_column :aliments, :vitaminB9, :float
    add_column :aliments, :vitaminB12, :float
  end
  
  def down
    remove_column :aliments, :vitaminB2
    remove_column :aliments, :vitaminB3
    remove_column :aliments, :vitaminB5
    remove_column :aliments, :vitaminB6
    remove_column :aliments, :vitaminB9
    remove_column :aliments, :vitaminB12
  end
end
