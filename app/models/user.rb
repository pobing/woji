class User < ActiveRecord::Base
  attr_accessible :avatat_id, :email, :hashed_password, :login, :name, :nick_name, :phone, :salt, :sex
end
