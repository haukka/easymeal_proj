# == Schema Information
#
# Table name: aliments_quantities
#
#  id         :integer          not null, primary key
#  aliment_id :integer
#  recipe_id  :integer
#  quantity   :integer
#

class AlimentsQuantity < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :aliment

  validate :quantity
  # validate :has_recipes?
  validate :has_aliments?

  # def has_recipes?
  #   errors.add(:base, 'aliments_quantity must have a recipe.') if self.recipe.nil?
  # end
  
  def has_aliments?
    errors.add(:base, 'aliments_quantity must have an aliment.') if self.aliment.nil?
  end
end
