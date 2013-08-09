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

class Feedback < ActiveRecord::Base
  attr_accessible :content, :email, :title
end
