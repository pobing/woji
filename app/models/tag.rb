# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  taggings_count :integer
#

class Tag < ActiveRecord::Base
  attr_accessible :count, :name, :post_id
  # belongs_to :post
  has_many :taggings
  has_many :posts ,:through =>:taggings
  default_scope :order => 'created_at DESC'
  # def self.save_tags(tags,post_id)
  # 	tags.split(",").each do |t|
  #     attr = {:name => t , :post_id =>post_id }
  #     Tag.create attr	
  #   end
  # end
  def self.tags(tags)
    tag_arr = []
    tags.split(",").each do |t|
      attr = {:name => t}
      tag = Tag.new(attr)
      tag_arr << tag
      #Tag.create attr	
    end
    tag_arr
  end
end
