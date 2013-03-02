#coding:utf-8
class Post < ActiveRecord::Base
  attr_accessible :content, :item_type, :title,:tags,:tags_attributes
  has_many :tags
  default_scope :order => 'created_at DESC'
  # accepts_nested_attributes_for :tags, :allow_destroy => :true,
  #   :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  module Type
    TWEET = 0
    DAY = 1
    WEEK = 2
    MONTH = 3
    YEAR = 4
    AUTOBIOG = 5
  end

  def type_s
    s = case self.item_type.to_i
    when Type::TWEET then "说说"
    when Type::DAY then "日记"
    when Type::WEEK then "周记"
    when Type::MONTH then "月记"
    when Type::YEAR then "年记"
    when Type::AUTOBIOG then "自传"
    end
    s
  end

  def self.tweet_title(str)
    str.slice(0..9)
  end

  def self.recently_posts
    Post.where("item_type>0" ).first 5
  end
end
