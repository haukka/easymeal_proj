class CreateDietTypes < ActiveRecord::Migration
  def change
    create_table :diet_types do |t|
      t.belongs_to :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
