# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Authentication do
  pending "add some examples to (or delete) #{__FILE__}"
end
