# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: aliments_quantities
#
#  id               :integer          not null, primary key
#  aliment_id       :integer
#  recipe_id        :integer
#  quantity         :integer
#  shopping_list_id :integer
#  stock_id         :integer
#

class AlimentsQuantity < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :aliment
  belongs_to :shopping_lists
  belongs_to :stock

  validates :quantity, presence: true
  # validate :has_recipes?
  validate :has_aliments?

  # def has_recipes?
  #   errors.add(:base, 'aliments_quantity must have a recipe.') if self.recipe.nil?
  # end
  
  def has_aliments?
    errors.add(:base, 'aliments_quantity must have an aliment.') if self.aliment.nil?
  end
end
