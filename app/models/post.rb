#coding:utf-8
# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  item_type  :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ActiveRecord::Base
  attr_accessible :content, :item_type, :title, :tags, :tags_attributes
  has_many :tags
  default_scope :order => 'created_at DESC'

  validates :title, :length => {maximum: 50, message: "标题最长为50个字符"}
  # self.per_page = 3
  module Type
    TWEET = 0
    DAY = 1
    WEEK = 2
    MONTH = 3
    YEAR = 4
    AUTOBIOG = 5
  end

  def self.tweet_title(str)
    str.slice(0..9)
  end

  def self.recently_posts
    Post.where("item_type>0").first 5
  end

  def type_s
    s = case self.item_type.to_i
      when Type::TWEET then
        "说说"
      when Type::DAY then
        "日记"
      when Type::WEEK then
        "周记"
      when Type::MONTH then
        "月记"
      when Type::YEAR then
        "年记"
      when Type::AUTOBIOG then
        "自传"
      end
    s
  end
end
