class CreateAliments < ActiveRecord::Migration
  def change
    create_table :aliments do |t|
      t.string :name
      t.float :calories
      t.float :sugar
      t.float :protein
      t.float :fat
      t.float :fiber
      t.float :iron
      t.float :magnesium
      t.float :vitaminA
      t.float :vitaminB
      t.float :vitaminC
      t.float :vitaminD
      t.float :vitaminE
      t.boolean :isQuantifiable
      t.float :quantity
      t.float :weight
      t.float :averagePrice
      
      t.timestamps
    end
  end
end
