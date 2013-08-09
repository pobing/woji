# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Site do
  pending "add some examples to (or delete) #{__FILE__}"
end
