# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: shopping_lists
#
#  id         :integer          not null, primary key
#  totalPrice :float
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

class ShoppingList < ActiveRecord::Base
  belongs_to :home
  has_many :aliments_quantity
#  has_and_belongs_to_many :aliments
  
  validates :home, presence: true
  validate :has_name?

  def has_name?
    errors.add(:base, 'stock must have a name.') if self.name.nil?
  end
end
