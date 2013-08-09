# == Schema Information
#
# Table name: disk_files
#
#  id             :integer          not null, primary key
#  file_name      :string(255)
#  digest         :string(255)
#  user_id        :integer
#  mime_type      :string(255)
#  file_size      :integer
#  container_type :string(255)
#  container_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class DiskFile < ActiveRecord::Base
  attr_accessible :digest, :file_name, :user_id
  belongs_to :user

  def container_user?
  	self.container_type == "User"
  end
end
