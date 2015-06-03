# == Schema Information
#
# Table name: diseases
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class DiseaseTest < ActiveSupport::TestCase

  test "disease is valid" do
    disease = FactoryGirl.build(:disease, name: "maladie de chron")
    assert disease.valid?
  end

  test "disease is invalid without name" do
    disease = FactoryGirl.build(:disease, name: nil)
    assert disease.valid? "disease must have a name"
  end

end
