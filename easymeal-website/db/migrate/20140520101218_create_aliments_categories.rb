# -*- encoding : utf-8 -*-
class CreateAlimentsCategories < ActiveRecord::Migration
  def change
    create_table :aliments_categories do |t|
      t.belongs_to :aliment
      t.belongs_to :category
    end
  end
end
