class RemoveVitaminAFromAliments < ActiveRecord::Migration
  def up
    remove_column :aliments, :vitaminA
  end
  
  def down
    add_column :aliments, :vitaminA, :float
  end
end
