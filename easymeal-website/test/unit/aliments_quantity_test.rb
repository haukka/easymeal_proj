# == Schema Information
#
# Table name: aliments_quantities
#
#  id               :integer          not null, primary key
#  aliment_id       :integer
#  recipe_id        :integer
#  quantity         :integer
#  shopping_list_id :integer
#  stock_id         :integer
#

require 'test_helper'

class AlimentQuantityTest < ActiveSupport::TestCase
  
  def setup
    @diet = FactoryGirl.create(:diet_type, name: 'stabilization')
    @category = FactoryGirl.create(:category)
    @blue_cheese = FactoryGirl.create(:aliment, categories: [@category])
  end
  
  test "aliments_quantity is valid" do
    alimentsqt = FactoryGirl.build(:aliments_quantity, aliment_id: @blue_cheese.id, quantity: 2)
    assert alimentsqt.valid?
  end

  test "aliments_quantity invalid without a quantity" do
    alimentsqt = FactoryGirl.build(:aliments_quantity, aliment_id: @blue_cheese.id, quantity: nil)
    assert !alimentsqt.valid?, "aliments_quantity must have a quantity"
  end

  test "aliments_quantity invalid without an aliment" do
    alimentsqt = FactoryGirl.build(:aliments_quantity, aliment_id: nil, quantity: 2)
    assert !alimentsqt.valid?, "aliments_quantity must have an aliment"
  end
end
