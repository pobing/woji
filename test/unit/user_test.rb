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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
