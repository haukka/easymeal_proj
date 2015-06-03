class AddIdentToAliments < ActiveRecord::Migration
  def change
    add_column :aliments, :ident, :integer
  end
end
