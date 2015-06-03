class RenameFibresToFibersInAliments < ActiveRecord::Migration
  def up
    rename_column :aliments, :fibres, :fiber
  end
  
  def down
    rename_column :aliments , :fiber, :fibres
  end
end
