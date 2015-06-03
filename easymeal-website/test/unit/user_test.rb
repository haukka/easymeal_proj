# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  firstname              :string(255)
#  lastname               :string(255)
#  password               :string(255)
#  gender                 :string(255)
#  birth                  :date
#  role                   :integer
#  lastConnexion          :date
#  loginAttempts          :integer
#  lock                   :date
#  islock                 :boolean
#  resetToken             :string(255)
#  highCholesterol        :boolean
#  highBloodPressure      :boolean
#  height                 :integer
#  weight                 :integer
#  desireWeight           :integer
#  idealWeight            :integer
#  home_id                :integer
#  weightPointId          :integer
#  dietTypeId             :integer
#  weightCurveId          :integer
#  created_at             :datetime
#  updated_at             :datetime
#  auth_token             :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  photo_file_name        :string(255)
#  photo_content_type     :string(255)
#  photo_file_size        :integer
#  photo_updated_at       :datetime
#  isAdmin                :boolean          default(FALSE)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    FactoryGirl.create(:diet_type, name: 'stabilization')
  end
  
  test "user is valid" do
    user = FactoryGirl.build(:user)
    assert user.valid?
  end

  test "user invalide without a username" do
    user = FactoryGirl.build(:user, username: nil)
    assert !user.valid?, "user must have a username"
  end

  test "user invalide without a email" do
    user = FactoryGirl.build(:user, email: nil)
    assert !user.valid?, "user must have a email"
  end

  test "user invalide without a password" do
    user = FactoryGirl.build(:user, password: nil)
    assert !user.valid?, "user must have a password"
  end

  test "user invalide without a firstname" do
    user = FactoryGirl.build(:user, firstname: nil)
    assert !user.valid?, "user must have a firstname"
  end

  test "user invalide without a lastname" do
    user = FactoryGirl.build(:user, lastname: nil)
    assert !user.valid?, "user must have a lastname"
  end

  test "user invalide without a gender" do
    user = FactoryGirl.build(:user, gender: nil)
    assert !user.valid?, "user must have a gender"
  end

  test "user valid without a birth date" do
     user = FactoryGirl.build(:user, birth: nil)
    assert !user.valid?, "user should be invalid without a birth date"
  end

  test "user valid without a height" do
     user = FactoryGirl.build(:user, height: nil)
    assert !user.valid?, "user should be invalid without a height"
  end

  test "user valid without a weight" do
     user = FactoryGirl.build(:user, weight: nil)
    assert user.valid?, "user should be valid without a weight"
  end

  test "user valid without a desireweight" do
     user = FactoryGirl.build(:user, desireWeight: nil)
    assert user.valid?, "user should be valid without a desireWeight"
  end

  test "user valid without a idealweight" do
     user = FactoryGirl.build(:user, idealWeight: nil)
    assert user.valid?, "user should be valid without a idealWeight"
  end

  test "user valid without a highCholesterol" do
    user = FactoryGirl.build(:user, highCholesterol: nil)
    assert user.valid?, "user should be valid without a highCholesterol"
  end

  test "user valid without a highBloodPressure" do
    user = FactoryGirl.build(:user, highBloodPressure: nil)
    assert user.valid?, "user should be valid without a highBloodPressure"
  end
end
