# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  country    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class StoreTest < ActiveSupport::TestCase

  test "store is valid" do
    store = FactoryGirl.build(:store)
    assert store.valid?
  end

  test "store invalid without name" do
    store = FactoryGirl.build(:store, name: nil)
    assert !store.valid?, "A store must have a name"
  end

  test "store valid without country" do
    store = FactoryGirl.build(:store, country: nil)
    assert store.valid?, "A store should be valid without a country"
  end
end
