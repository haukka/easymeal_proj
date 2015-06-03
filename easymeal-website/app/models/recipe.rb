# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: recipes
#
#  id                 :integer          not null, primary key
#  text               :text
#  time               :integer
#  difficulty         :integer
#  calories           :integer
#  price              :float
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string(255)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  recipe_day         :boolean          default(FALSE)
#  workflow_state     :string(255)
#  nb_servings        :integer          default(1)
#

class Recipe < ActiveRecord::Base
  include Workflow
  has_many :aliments_quantity
  has_and_belongs_to_many :menu_schedules
  has_and_belongs_to_many :recipe_categories

  validates_presence_of :time, :difficulty, :price, :name, :text
  
  accepts_nested_attributes_for :aliments_quantity, :allow_destroy => true

  has_attached_file :photo, :styles => { :medium => "400x400#", :thumb => "210x210#", :thumb_large => "254x190#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  workflow do
  
    state :pending do
      event :validate, :transitions_to => :validated
      event :refuse, :transitions_to => :refused
    end
  
    state :refused do
      event :modify, :transitions_to => :pending
    end
  
    state :validated do 
      event :modify, :transitions_to => :pending
    end
    
  end
  
  def search(search, order = "updated_at")
    if search
      find(:all, conditions: ["LOWER(recipe.name.downcase) LIKE ? OR recipe.text.downcase LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%"], order: "recipe.#{order} ASC")
    end
  end
  
  def self.validated
    Recipe.with_validated_state
  end
  
  def self.get_recipe_day
    recipe_day = Recipe.where(recipe_day: true).take
    if recipe_day.nil?
      recipe_day = Recipe.with_validated_state.order_by_rand.first
      recipe_day.update(recipe_day: true)
    end
    return recipe_day
  end

  def self.new_recipe_day
    current = Recipe.get_recipe_day
    recipe_day = Recipe.with_validated_state.order_by_rand.first
    
    while (recipe_day == current)
      recipe_day = Recipe.with_validated_state.order_by_rand.first
    end
    
    Recipe.where(recipe_day: true).each do |recipe|
      recipe.update(recipe_day: false)
    end
    
    recipe_day.update(recipe_day: true)
  end
  
  def self.entries
    RecipeCategory.find_by(name: "Entrée").recipes
  end
  
  def self.dishes
    RecipeCategory.find_by(name: "Plat").recipes
  end
  
  def self.desserts
    RecipeCategory.find_by(name: "Dessert").recipes
  end
  
  def self.collations
    RecipeCategory.find_by(name: "Goûter").recipes
  end
  
  def self.liked user
    ids_to_exclude = user.allergen_and_favorite_aliments.where(allergy: true)
    ids_to_exclude += user.allergen_and_favorite_aliments.where(favori: false)
    ids_to_exclude.uniq!
    recipes = self.validated
    recipes = recipes.where.not(id: ids_to_exclude) if recipes.count > 0
    return recipes
  end

end
