# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: exceeds
#
#  id         :integer          not null, primary key
#  disease_id :integer
#  aliment_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Exceed < ActiveRecord::Base
  belongs_to :aliment
  belongs_to :disease
end
