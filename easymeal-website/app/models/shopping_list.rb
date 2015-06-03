# == Schema Information
#
# Table name: shopping_lists
#
#  id         :integer          not null, primary key
#  totalPrice :float
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ShoppingList < ActiveRecord::Base
  belongs_to :home
  has_and_belongs_to_many :aliments
  
  validates :home, presence: true
end
