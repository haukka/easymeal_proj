# -*- encoding : utf-8 -*-
class AddIdentToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ident, :string
  end
end
