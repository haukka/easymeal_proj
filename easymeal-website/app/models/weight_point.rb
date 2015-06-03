# == Schema Information
#
# Table name: weight_points
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  weight     :integer
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

class WeightPoint < ActiveRecord::Base
  belongs_to :user

  validates :weight, presence: true
  validates :date, presence: true
  validate :has_user?

  def has_user?
    errors.add(:base, 'WeightPoint must have belongs_to a user.') if self.user.nil?
  end
end
