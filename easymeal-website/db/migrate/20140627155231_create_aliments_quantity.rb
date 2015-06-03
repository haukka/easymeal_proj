class CreateAlimentsQuantity < ActiveRecord::Migration
  def change
    create_table :aliments_quantities do |t|
      t.belongs_to  :aliment
      t.belongs_to  :recipe
      t.integer     :quantity
    end
  end
end
