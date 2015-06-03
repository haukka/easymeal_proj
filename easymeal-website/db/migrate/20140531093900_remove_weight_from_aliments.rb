# -*- encoding : utf-8 -*-
class RemoveWeightFromAliments < ActiveRecord::Migration
  def up
    remove_column :aliments, :weight
  end
  
  def down
    add_column :aliments, :weight, :float
  end
end
