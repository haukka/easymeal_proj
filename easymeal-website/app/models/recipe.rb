# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  text       :text
#  time       :integer
#  difficulty :integer
#  calories   :integer
#  price      :float
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

class Recipe < ActiveRecord::Base
  has_many :aliments_quantity
 
  # validate :has_aliments_quantity?
  validates_presence_of :time, :difficulty, :price, :name, :text
  
  accepts_nested_attributes_for :aliments_quantity, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  # def has_aliments_quantity?
#      errors.add(:base, 'Recipe must have at least one aliments_quantity.') if self.has_aliments_quantity?.blank?
#   end
  
  def liked
    if current_user
      ids_to_exclude = current_user.allergen_and_favorite_aliments.where(allergy: true)
      ids_to_exclude += current_user.allergen_and_favorite_aliments.where(favori: false)
      ids_to_exclude.uniq!
      self.where.not(id: ids_to_exclude)
    end
  end
  
  def search(search, order = "updated_at")
    if search
      find(:all, conditions: ["LOWER(recipe.name.downcase) LIKE ? OR recipe.text.downcase LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%"], order: "recipe.#{order} ASC")
    end
  end
end
