#coding:utf-8
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

    # 精彩（nice）时间格式化
  # def status_time_ago_in_words(dt)
  #   time = time_ago_in_words(dt)
  #   Rails.logger.debug "debug time == #{time}"
  #   case time
  #   when "不到一分钟"
  #     "刚刚"
  #   when /minute/
  #     time.gsub(/minutes|minute/, '分钟') + "前"
  #   when /hour|days|day/
  #     if dt.to_date == Time.now.to_date then
  #       time.gsub(/about (\d+) (hours|hour)/, '\1小时') + "前"
  #     elsif dt.to_date == Time.now.yesterday.to_date then
  #       "昨天#{dt.strftime(' %H:%M')}"
  #     elsif dt.to_date == Time.now.ago(172800).to_date then
  #       "前天#{dt.strftime(' %H:%M')}"
  #     else
  #       dt.strftime("%Y-%m-%d %H:%M")
  #     end
  #   else
  #     dt.strftime("%Y-%m-%d %H:%M")
  #   end
  # end
end
