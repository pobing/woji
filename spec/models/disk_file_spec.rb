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

require 'spec_helper'

describe DiskFile do
  pending "add some examples to (or delete) #{__FILE__}"
end
