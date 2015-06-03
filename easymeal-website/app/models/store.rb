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

class Store < ActiveRecord::Base
  has_and_belongs_to_many :home

  validates :name, presence: true
end
