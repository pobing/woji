# encoding:utf-8
class Admin::SitesController < ApplicationController
  layout 'admin'

  before_filter :set_site ,:only=>[:edit,:update,:destroy]

  def index
    @sites = Site.paginate(page: params[:page])
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
