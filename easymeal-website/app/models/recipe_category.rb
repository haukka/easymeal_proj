# == Schema Information
#
# Table name: recipe_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class RecipeCategory < ActiveRecord::Base
  has_and_belongs_to_many :recipes
end
