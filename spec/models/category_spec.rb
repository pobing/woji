# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  category_id :integer
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  posts_count :integer          default(0)
#  type        :string(255)
#

require 'spec_helper'

describe Category do
  pending "add some examples to (or delete) #{__FILE__}"
end
