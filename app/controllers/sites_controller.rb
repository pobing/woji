# encoding:utf-8
class SitesController < ApplicationController
 layout 'manage'
  def index
   # render :layout => 'manage'
  end

  def new
  	@site = Site.new
    render :layout => 'application'
  end
  
  def add_by_md
    sites = params[:sites]
    name = sites.scan(/\[(.*?)\]/).flatten.uniq[0]
    url = sites.scan(/\((.*?)\)/).flatten.uniq[0]
    unless name.nil? && url.nil?
      attr = {:name =>name,:url=>url}
      site = Site.new(attr)
      if site.save
        post = Post.new({:title => name,:content => sites,:item_type => Post::Type::SITE ,:user_id =>current_user.id})
        post.update_tags("好站") if post.save
      	flash.now.alert = "Add site success"
      	redirect_to posts_path
      else
        flash.now.alert = "Add site failure"
      	redirect_to posts_path
      end
    end
  end

  def destroy
  end

end
