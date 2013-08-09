# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  commenter  :string(255)
#  body       :text
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :commenter
end
