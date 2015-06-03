# == Schema Information
#
# Table name: aliments
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  calories       :float
#  sugar          :float
#  protein        :float
#  cholesterol    :float
#  fiber          :float
#  iron           :float
#  magnesium      :float
#  vitaminB1      :float
#  vitaminC       :float
#  vitaminD       :float
#  vitaminE       :float
#  isQuantifiable :boolean
#  quantity       :float
#  averagePrice   :float
#  created_at     :datetime
#  updated_at     :datetime
#  vitaminB2      :float
#  vitaminB3      :float
#  vitaminB5      :float
#  vitaminB6      :float
#  vitaminB9      :float
#  vitaminB12     :float
#  ident          :integer
#

require 'test_helper'

class AlimentTest < ActiveSupport::TestCase
  
  def setup
    @diet = FactoryGirl.create(:diet_type, name: 'stabilization')
    @category = FactoryGirl.create(:category)
  end
  
  test "aliment is valid" do
    aliment = FactoryGirl.build(:aliment, categories: [@category])
    assert aliment.valid?
  end
  
  test "aliment invalid without name" do
    aliment = FactoryGirl.build(:aliment, name: nil, categories: [@category])
    assert !aliment.valid?, "An aliment must have a name."
  end
  
  test "aliment invalid without a category" do
    aliment = FactoryGirl.build(:aliment, categories: [])
    assert !aliment.valid?, "An aliment must have a category."
  end
  
  test "aliment valid without a home" do
    aliment = FactoryGirl.build(:aliment, categories: [@category], home: [])
    assert aliment.valid?, "An aliment must be valid without a home."
  end
  
  test "aliment invalid without a price" do
    aliment = FactoryGirl.build(:aliment, categories: [@category], averagePrice: nil)
    assert !aliment.valid?, "An aliment must have an average price."
  end  
end
