# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  login           :string(255)
#  name            :string(255)
#  nick_name       :string(255)
#  email           :string(255)
#  phone           :string(255)
#  avatat_id       :integer
#  hashed_password :string(255)
#  salt            :string(255)
#  sex             :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :avatat_id, :email, :hashed_password, :login, :name, :nick_name, :phone, :salt, :sex
  has_secure_password
  before_save { |user| user.email= email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX},
            uniqueness: true
  validates :name, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  #user.authenticate("invalid")
end
