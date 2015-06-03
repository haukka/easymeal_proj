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
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :home
  has_one :diet_type
  has_many :weight_points
  has_and_belongs_to_many :diseases
  has_and_belongs_to_many :menu_schedules

  validates :username, presence: true
  validates :password, presence: true, on: :create
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :gender, presence: true

  after_initialize :init

  def init
    self.diet_type = DietType.find(1) if self.diet_type.nil?
  end
  
  before_create { 
    generate_token(:auth_token)
   }
   
   def generate_token(column)
     begin
       self[column] = SecureRandom.urlsafe_base64
     end while User.exists?(column => self[column])
   end
end
