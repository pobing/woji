class Category < ActiveRecord::Base
  attr_accessible :category_id, :name
  has_many :posts,:foreign_key =>:item_type
  has_many :sites 
  after_save :generate_category_id
  
  private
  def generate_category_id
  	update_attribute(:category_id, "%05d" % id) unless category_id
  end
end
