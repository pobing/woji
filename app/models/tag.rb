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
   	tag_arr =  []
  	tags.split(",").each do |t|
      attr = {:name => t }
      tag = Tag.new(attr)
      tag_arr << tag
      #Tag.create attr	
    end
    tag_arr
  end
end
