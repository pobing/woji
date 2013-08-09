#encoding:utf-8
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  login                  :string(255)
#  name                   :string(255)
#  nick_name              :string(255)
#  email                  :string(255)
#  phone                  :string(255)
#  salt                   :string(255)
#  sex                    :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  status                 :integer          default(0)
#  is_admin               :integer          default(0)
#  website                :string(255)
#  active_token           :string(255)
#  avatar                 :string(255)
#  avatar_id              :integer
#  auth_avatar            :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation,  :email, :hashed_password, :login, :name, :nick_name, :phone, :salt, :sex,
  :website, :status,:is_admin,:auth_avatar
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :authentications
  belongs_to :disk_file , :foreign_key=>"avatar_id"
  before_save { |user| user.email= email.downcase if email}
  before_save { generate_token(:remember_token) }
  mount_uploader :avatar, Uploader
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

  def self.from_auth(auth)
    Authentication.find_by_provider_and_uid(auth[:provider],auth[:uid]).try(:user) || self.new_by_auth(auth)
  end
 
  def self.new_by_auth(auth)
    attr = {:nick_name => auth[:info][:nickname],
          :email => auth[:info][:email],
          :name =>auth[:info][:name],
          :auth_avatar =>auth[:info][:image],
          :website => auth[:info][:urls][:Blog]}
    user = User.new(attr)
    user.authentications.new(:provider => auth[:provider],:uid=>auth[:uid])
    user.save(:validate=>false)
    user
    # user.authentications.provider = auth[:provider]
    # user.authentications.uid

  end

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

  def full_name
    self.name || self.login || self.email 
  end
  
  def thumb_avatar
   self.auth_avatar ||  self.avatar_url(:thumb) || "#{default_avatar_dir}/thumb.png"
  end

  def small_avatar
    self.auth_avatar || self.avatar_url(:small) || "#{default_avatar_dir}/small.png"
  end

  def normal_avatar
    self.auth_avatar ||  self.avatar_url(:normal) || "#{default_avatar_dir}/normal.png"
  end

  def to_j(options={})
    h = { id: id, name: name, email: email}
    default = h
    if options.try(:[],:only)
      only = options[:only]
      h.merge!({ full_name: full_name }) if only.index(:full_name)
      h.merge!({ login: login }) if only.index(:login)
      h.merge!({ sex: sex }) if only.index(:sex)
      h.merge!({ avatar: avatar }) if only.index(:avatar)
      h.merge!({ created_at: created_at}) if only.index(:created_at)
      h.merge!({ admin: is_admin }) if only.index(:is_admin)
      h.merge!({ phone: self.phone}) if only.index(:phone)
      h = h.select { |k,v| only.include?(k) }
      h.merge! default
    end
    h
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

  def default_avatar_dir
    "/img/avatar"
  end
  

end
