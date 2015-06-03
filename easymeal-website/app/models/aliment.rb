# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: aliments
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  calories       :float
#  sugar          :float
#  protein        :float
#  cholesterol    :float
#  fiber          :float
#  iron           :float
#  magnesium      :float
#  vitaminB1      :float
#  vitaminC       :float
#  vitaminD       :float
#  vitaminE       :float
#  isQuantifiable :boolean
#  quantity       :float
#  averagePrice   :float
#  created_at     :datetime
#  updated_at     :datetime
#  vitaminB2      :float
#  vitaminB3      :float
#  vitaminB5      :float
#  vitaminB6      :float
#  vitaminB9      :float
#  vitaminB12     :float
#  ident          :integer
#

class Aliment < ActiveRecord::Base
  has_and_belongs_to_many :home
  has_and_belongs_to_many :categories
#  has_and_belongs_to_many :shopping_lists
  has_many :aliments_quantity
  
  has_many :proscribes
  has_many :diseases, :through => :proscribes

  has_many :moderates
  has_many :diseases, :through => :moderates

  has_many :exceeds
  has_many :diseases, :through => :exceeds
  
  validates :name, uniqueness: true, presence: true
  validates :averagePrice, presence: true
  validate :has_categories?

  def has_categories?
     errors.add(:base, 'Aliment must have at least one category.') if self.categories.blank?
  end
end
