#encoding:utf-8
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
  attr_accessible :password, :password_confirmation, :avatat_id, :email, :hashed_password, :login, :name, :nick_name, :phone, :salt, :sex,
  :website, :status,:is_admin
  has_secure_password
  has_many :posts
  has_many :comments
  before_save { |user| user.email= email.downcase if email}
  before_save { generate_token(:remember_token) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
            :uniqueness => { message: "Email已经存在"}
  validates :name, :length => { maximum: 50,:message=> "姓名不能超过50字符"}
  validates :login, :length => { maximum: 50,:message=> "登录名不能超过50字符"} #, uniqueness: { :message => "登录名已存在"}
  # validates :password, presence: true, length: {minimum: 6}, :if => :password_required?
  # validates :password_confirmation, presence: true
  validates :password_confirmation , :presence =>{:message=>"确认密码不能为空"} ,:if=>:password_required?        
  validates :password , :confirmation => {:message=>"确认密码错误"} , :if => :password_required?        
  validates :password ,:length     => { :within => 6..40 ,:message=>"用户密码必须6-40个字符" } , :if => :password_required?

  def send_password_reset
     generate_token(:password_reset_token)
     self.password_reset_sent_at = Time.zone.now
     save(:validate =>false)
     UserMailer.password_reset(self).deliver
  end
  
  def send_acitve_mail
     generate_token(:active_token)
     save(:validate =>false)
    # UserMailer.password_reset(self).deliver
  end

  def is_admin?
    self.is_admin == 1 
  end
  
  def sex_name
    self.sex ==0 ? "女" : "男"
  end
  private
  def generate_token(column)
    begin 
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column=> self[column]) 
  end
  def password_required?
    self.password_digest.blank? || !password.blank?
  end
end
