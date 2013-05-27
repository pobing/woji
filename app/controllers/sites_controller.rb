# encoding:utf-8
class SitesController < ApplicationController
  layout 'manage'

  before_filter :set_site ,:only=>[:edit,:update,:destroy]

  def index
    @sites = Site.all
  end

  def new
  	@site = Site.new
  end
  
  def create
    attr = {:name=>params[:site][:name],:url=>params[:site][:url],:category_id=>params[:post][:item_type][1]}
    @site = Site.new(attr)
    if @site.save
      redirect_to sites_path
    else
      flash.now.alert = @site.errors
      render :action=>"new"
    end
  end

  def add_by_md
    sites = params[:sites]
    name = sites.scan(/\[(.*?)\]/).flatten.uniq[0]
    url = sites.scan(/\((.*?)\)/).flatten.uniq[0]
    unless name.nil? && url.nil?
      attr = {:name =>name,:url=>url}
      site = Site.new(attr)
      respond_to do |format| 
        if site.save
          post = Post.new({:title => name,:content => sites,:item_type => Post::Type::SITE ,:user_id =>current_user.id})
          post.update_tags("好站") if post.save
        	# flash.now.alert = "Add site success"
        	# redirect_to posts_path
          format.json{ render:json=>{:retCode=>1,:item=>post.to_j(post_options) } }
        else
          #flash.now.alert = "Add site failure"
          format.json{ render:json=>{:retCode=>0, :errors=> site.errors } }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @site.destroy
        format.json { render_json_ok } 
      else
        format.json { render_json_fail } 
      end
    end
  end
  
  def edit
  end

  def update
    attr = {:name=>params[:site][:name],:url=>params[:site][:url],:category_id=>params[:post][:item_type][1]}
    if  @site.update_attributes attr
      redirect_to sites_path
    else
      render :edit
    end
  end

  protected
  
  def post_options
    {:only => [:content,:author,:comments_count,:date,:created_at,:type,:tags]}
  end
  
  def set_site
    @site = Site.find_by_id(params[:id])
  end
end
