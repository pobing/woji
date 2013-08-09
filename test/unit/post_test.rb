# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  item_type      :integer
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  comments_count :integer
#  visited_count  :integer          default(0)
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
