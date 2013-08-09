# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Feedback do
  pending "add some examples to (or delete) #{__FILE__}"
end
