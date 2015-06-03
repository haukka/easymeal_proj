# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  ident      :string(255)
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    
	test "category is valid" do
    category = FactoryGirl.build(:category)
  	assert category.valid?
	end
  
	test "category invlid without name" do
		category = FactoryGirl.build(:category, name: nil)
		assert !category.valid?, "A category must have a name."
	end
  
end
