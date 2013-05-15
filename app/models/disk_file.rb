class DiskFile < ActiveRecord::Base
  attr_accessible :digest, :file_name, :user_id
end
