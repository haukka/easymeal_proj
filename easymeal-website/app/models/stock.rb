# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  home_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

class Stock < ActiveRecord::Base
  belongs_to :home
  has_many :aliments_quantity

  validates :home, presence: true
  validate :has_name?

  def has_name?
    errors.add(:base, 'stock must have a name.') if self.name.nil?
  end
end
