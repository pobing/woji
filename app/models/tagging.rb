# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tagging < ActiveRecord::Base
  attr_accessible :post_id, :tag_id
  belongs_to :post
  belongs_to :tag,:counter_cache => true
end
