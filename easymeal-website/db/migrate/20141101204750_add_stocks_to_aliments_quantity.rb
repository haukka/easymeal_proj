# -*- encoding : utf-8 -*-
class AddStocksToAlimentsQuantity < ActiveRecord::Migration
  def change
    add_column :aliments_quantities, :stock_id, :integer
  end
end
