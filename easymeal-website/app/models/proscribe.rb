# == Schema Information
#
# Table name: proscribes
#
#  id         :integer          not null, primary key
#  disease_id :integer
#  aliment_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Proscribe < ActiveRecord::Base
  belongs_to :aliment
  belongs_to :disease
end
