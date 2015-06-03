# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: diet_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'test_helper'

class DietTypeTest < ActiveSupport::TestCase
  
  test "dietType is valid" do
    diet_type = FactoryGirl.build(:diet_type)
    assert diet_type.valid?
  end

  test "dietType invalid without a name" do
    diet_type = FactoryGirl.build(:diet_type, name: nil)
    assert !diet_type.valid?
  end
end
