# == Schema Information
#
# Table name: diseases
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Disease < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :proscribes
  has_many :forbid, :through => :proscribes, :source => :aliment

  has_many :moderates
  has_many :tolerate, :through => :moderates, :source => :aliment

  has_many :exceeds
  has_many :big_quantity, :through => :exceeds, :source => :aliment
end
