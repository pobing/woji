# encoding: utf-8
# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

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
