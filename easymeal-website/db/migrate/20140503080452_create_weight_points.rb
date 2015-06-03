class CreateWeightPoints < ActiveRecord::Migration
  def change
    create_table :weight_points do |t|
      t.belongs_to :user, index: true
      t.integer :weight
      t.date :date

      t.timestamps
    end
  end
end
