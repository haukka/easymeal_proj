# == Schema Information
#
# Table name: diet_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class DietType < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
 # validate :has_user?

  def has_user?
    errors.add(:base, 'DietType must have belongs_to a user.') if self.user.nil?
  end
end
