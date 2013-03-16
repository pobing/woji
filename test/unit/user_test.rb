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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
