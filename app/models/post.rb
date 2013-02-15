class Post < ActiveRecord::Base
  attr_accessible :content, :item_type, :title
end
