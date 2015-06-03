# -*- encoding : utf-8 -*-
class RenameFiberToFibresInAliment < ActiveRecord::Migration
  def change
    rename_column :aliments, :fiber, :fibres
  end
end
