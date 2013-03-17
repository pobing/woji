# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  name       :string(255)
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  attr_accessible :count, :name, :post_id
  belongs_to :post
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
