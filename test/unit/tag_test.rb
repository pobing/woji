# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  name       :string(255)
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
