# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: homes
#
#  id             :integer          not null, primary key
#  street         :string(255)
#  city           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  householder_id :integer
#  zipcode        :string(255)
#  name           :string(255)
#

class Home < ActiveRecord::Base
  belongs_to :householder, class_name: "User"
  has_and_belongs_to_many :stores
  has_and_belongs_to_many :aliments
  has_many :users
  has_many :menu_schedules
  has_many :shopping_lists
  has_many :stocks

  validates :city, presence: true
  validates :name, presence: true
  validate :has_householder?

  after_save :init_stock_and_list

  def init_stock_and_list
    self.shopping_lists.create(:name => 'liste du planning')
    self.stocks.create(:name => 'Général')
  end

  def has_householder?
    errors.add(:base, 'home must have belongs_to a user.') if self.householder_id.nil?
  end
end
