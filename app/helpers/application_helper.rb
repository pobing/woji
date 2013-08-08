#coding:utf-8
module ApplicationHelper
  include TruncateHtmlHelper

  def get_tags
  	Tag.where("taggings_count >?",0)
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

  def categories
    Category.all
  end

  def sites
    Site.all
  end

  def archive_month
    Post.find(:all, :order => "created_at DESC").group_by { |post| post.created_at.strftime("%Y-%m")}
  end


  def time_local(time)
    time.strftime("%Y年%m月%d日")
  end

  def string_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S")
  end

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
          :filter_html =>true,
          :autolink => true, 
          :space_after_headers => true,
          :fenced_code_blocks => true,
          :no_intra_emphasis => true,
          :hard_wrap => true,
          :strikethrough =>true
        }
      markdown = Redcarpet::Markdown.new(HTMLwithCodeRay,options)
      markdown.render(text).html_safe if text
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_width=>2)
     # CodeRay.scan(code, language).div(:line_numbers => :table)
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
  
  def truncate(html)
    truncate_html(html, :length => 300, :omission => '', :break_token => '<!-- truncate -->')
  end

  def favicon
    raw "<link rel='shortcut icon' type='image/x-icon' href='#{ image_path('/favicon.ico')}' />"
  end

  def icon_opt(icon_str)
    "<i class=#{icon_str}></i>".html_safe
  end

  def category_array
    Category.all.map { |c| [c.name, c.category_id] } 
  end

  def site_name
    "woji"
  end
  
  # def flash_class(level)
  #   case level
  #   when :notice then "info"
  #   when :error then "error"
  #   when :alert then "warning"
  #   end
  # end
  
end
