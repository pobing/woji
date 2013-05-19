class DiskFile < ActiveRecord::Base
  attr_accessible :digest, :file_name, :user_id
  belongs_to :user

  def container_user?
  	self.container_type == "User"
  end
end
