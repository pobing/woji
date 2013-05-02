#encoding: utf-8
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
