# encoding: utf-8
class Site < ActiveRecord::Base
  attr_accessible :category_id, :name, :url
  belongs_to :category #,:foreign_key=>:item_type
  VALID_URL_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates :url, presence: true, format: {with: VALID_URL_REGEX},
            uniqueness: true

  def cat_name
  	self.category.try(:name) || "未分类"
  end
end
