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
  include ApplicationHelper
  attr_accessible :content, :item_type, :title, :tags,:user_id
  has_many :tags,:through =>:taggings
  has_many :taggings
  has_many :comments,:dependent => :destroy
  belongs_to :user
  belongs_to :category,:foreign_key=>:item_type, :counter_cache => true
  default_scope :order => 'created_at DESC'
  validates :title, :length => {maximum: 50, message: "标题最长为50个字符"}
   # self.per_page = 1
  scope :tag_with, lambda { |tag_name| joins(:tags).where("tags.name=?",tag_name)} 
  scope :less_than, lambda { |time| joins(:taggings).where("taggings.created_at > ?",time) }

  module Type
    TWEET = 0
    DAY = 1
    IT = 2
    SITE = 3
  end

  def self.tweet_title(str)
    str.slice(0..12)
  end

  def self.recently_posts
    Post.where("item_type>0").first 10
  end

  def type_s
    s = case self.item_type.to_i
      when Type::TWEET then
        "动态"
      when Type::DAY then
        "日记"
      when Type::IT then
        "IT"
      when Type::SITE then
        "网址"
      end
    s
  end

  def update_tags(tags)
    tags.split(',').each do |t| 
      tag = Tag.find_by_name(t)
      tag = Tag.create({name: t }) if tag.nil?
      unless Tagging.exists?(post_id:self.id, tag_id: tag.id)
        self.taggings << Tagging.new({tag_id:tag.id})
      end
    end
    self.save
  end 

  def tag_list
    self.tags.map(&:name).join(",")
  end

  def author
    self.user.try(:name) || "匿名"
  end

  def html
    markdown(self.content)
  end

  def summary
    truncate(html)
  end

  def previous_post
    self.class.where("item_type > ? and created_at < ?",Type::TWEET,self.created_at ).first
  end

  def next_post
    self.class.where("item_type > ? and created_at > ?",Type::TWEET,self.created_at ).last
  end

  def similar_post
    self.class.where("item_type > ? and item_type > ?",Type::TWEET,self.item_type ).first 5
  end

  def category_name
    self.category.try(:name) || "动态"
  end


  define_index do
    indexes content
    indexes :title, sortable: true
    indexes comments.content, as: :comment_content
    indexes [user.name, user.email], as: :author_name
    
    #has author_id, published_at
  end

  def to_j(options={})
    h = { id: id, title: title, category:category_name,}
    default = h
    if options.try(:[],:only)
      only = options[:only]
      h.merge!({ comments_count: comments_count || 0 }) if only.index(:comments_count)
      h.merge!({ author: self.user.to_j({:only=>[:full_name]}) }) if only.index(:author)
      h.merge!({ content: summary }) if only.index(:content)
      h.merge!({ date: time_local(created_at) }) if only.index(:date)
      h.merge!({created_at: created_at}) if only.index(:created_at)
      h.merge!({type: item_type}) if only.index(:type)
      h.merge!({tags: self.tags}) if only.index(:tags)
      h = h.select { |k,v| only.include?(k) }
      h.merge! default
    end
    h
  end

end
