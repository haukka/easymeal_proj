# -*- encoding : utf-8 -*-
class RenameVitaminBToVitaminB1 < ActiveRecord::Migration
  def change
    rename_column :aliments, :vitaminB, :vitaminB1
  end
end
