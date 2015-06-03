# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: allergen_and_favorite_aliments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  aliment_id :integer
#  allergy    :boolean
#  created_at :datetime
#  updated_at :datetime
#  favori     :boolean
#

class AllergenAndFavoriteAliment < ActiveRecord::Base
  belongs_to :user
  belongs_to :aliment
  
  validate :has_user?
  validate :has_aliment?

  def has_user?
     errors.add(:base, 'Aliment must have belongs_to a user.') if self.user.nil?
  end
  
  def has_aliment?
     errors.add(:base, 'Aliment must have belongs_to an aliment.') if self.aliment.nil?
  end
end
