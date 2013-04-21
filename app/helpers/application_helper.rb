#coding:utf-8
module ApplicationHelper
  def get_tags
  	Tag.where("taggings_count >0",0)
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
  def time_local(time)
    time.strftime("%Y年%m月%d日")
  end
   def string_time(time)
    time.strftime("%Y-%m-%d")
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
  def full_title(page_title)
    base_title = "WoJi"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end


  def markdown(text)
      options = {   
          :autolink => true, 
          :space_after_headers => true,
          :fenced_code_blocks => true,
          :no_intra_emphasis => true,
          :hard_wrap => true,
          :strikethrough =>true
        }
      markdown = Redcarpet::Markdown.new(HTMLwithCodeRay,options)
      markdown.render(text).html_safe
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      #CodeRay.scan(code, language).div(:tab_width=>2)
      CodeRay.scan(code, language).div(:line_numbers => :table)
    end
  end



  def tag_cloud(tags, classes)
    max = tags.sort_by(&:taggings_count).last
    tags.each do |tag|
      unless tag.taggings_count.nil?
        index = tag.taggings_count.to_f / max.taggings_count * (classes.size - 1)
        yield(tag, classes[index.round])
      end

    end
  end


end
