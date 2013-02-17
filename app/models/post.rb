class Post < ActiveRecord::Base
  attr_accessible :content, :item_type, :title
  def type
  	type_str = if item_type == 0
  	  "riji"
  	  elsif item_type == 1
  	  "yueji" 
  	end
  	type_str
  end
end
