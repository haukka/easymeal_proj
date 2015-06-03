# == Schema Information
#
# Table name: moderates
#
#  id         :integer          not null, primary key
#  disease_id :integer
#  aliment_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Moderate < ActiveRecord::Base
  belongs_to :aliment
  belongs_to :disease
end
