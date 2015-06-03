# -*- encoding : utf-8 -*-
class RenameFatToCholesterolInAliments < ActiveRecord::Migration
  def change
    rename_column :aliments, :fat, :cholesterol
  end
end
