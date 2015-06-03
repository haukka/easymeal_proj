# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

require 'test_helper'

class StockTest < ActiveSupport::TestCase
  
	def setup
          @category = FactoryGirl.create(:category)
          @blue_cheese = FactoryGirl.create(:aliment, categories: [@category])
          @sour_cream = FactoryGirl.create(:aliment, name:"sour cream", categories: [@category])
          @diet = FactoryGirl.create(:diet_type, name: 'stabilization')
          @user = FactoryGirl.create(:user)
          @home = FactoryGirl.build(:home, householder_id:@user.id)
          @aliments_quantity = FactoryGirl.build(:aliments_quantity,  aliment_id: @blue_cheese.id, quantity: 2)
	end
  
	test "stock is valid" do
          stock = FactoryGirl.build(:stock, aliments_quantity: [@aliments_quantity], home: @home, name: "toto")
          assert stock.valid?
	end

        test "stock valid without aliments" do
          stock = FactoryGirl.build(:stock, aliments_quantity: [], home: @home, name: "toto")
          assert stock.valid?
	end
  
	test "stock invalid without home" do
          stock = FactoryGirl.build(:stock, aliments_quantity: [@aliments_quantity], home: nil, name: "toto")
          assert !stock.valid?, "A stock must have a home."
	end
  
        test "stock invalid without name" do
          stock = FactoryGirl.build(:stock, aliments_quantity: [@aliments_quantity], home: @home, name: nil)
          assert !stock.valid?, "A stock must have a name."
	end
end
