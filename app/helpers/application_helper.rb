module ApplicationHelper
  def get_tags
  	Tag.all
  end

  def get_counts
  	all_count = Post.count
  	tweet_count = Post.where(:item_type=>0).count
  	diary_count = Post.where(:item_type=>1).count
  	counts = {:all_count=> all_count,:tweet_count=>tweet_count,:diary_count=>diary_count}
  end

  def recently_posts
  	Post.recently_posts
  end
end
