#encoding: utf-8
# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :content, :user_id
  belongs_to :user
  belongs_to :post,:counter_cache => true

  def commenter
  	self.user.try(:name) || "匿名"
  end

  def html
    markdown(self.content)
  end

end
