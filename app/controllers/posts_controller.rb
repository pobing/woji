# encoding:utf-8
class PostsController < ApplicationController
  before_filter :signed_in_user,:only=>[:create,:destroy,:post_tweet]

  def new
    @post = Post.new
  end

  def index
    @posts = if params[:type]
      Post.where(:item_type => params[:type].to_i).paginate(page: params[:page])
      else
        Post.paginate(page: params[:page])
      end
    respond_to do |format|
      format.html
      format.atom
    end
  end

  def create
    @post = Post.new(params[:post])
    @post.content= params[:content]
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        @post.update_tags(params[:tags])
        format.json {render :json=>{:retCode=>1,:msg=>"success!"}}
      else
        render action: "new"
      end
    end
  end

  def post_tweet
    type = Post::Type::TWEET
    message = params[:message]
    attr = {:title => Post.tweet_title(message), :content => message, :item_type => type,:user_id => current_user.id}
    post = Post.create attr
    respond_to do |format|
      if post
       tags = post.content.scan(/#(.*?)#/).flatten.uniq
       post.update_tags(tags)
       format.json { render :json=>{:retCode=>1,:item => post.to_j(post_options)} } 
      end
    end
  end

  def post_blog
    attr = {:title => params[:title], :content => params[:message], :item_type => params[:item_type],:user_id => current_user.id}
    post = Post.new(attr)
    respond_to do |format|
      if post.save
        post.update_tags(params[:tags])
        format.json { render :json=>{:retCode=>1,:item => post.to_j(post_options)} } 
      else
        # flash.now.alert = post.erros
        render action: "new"
      end
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    if @post
      Post.update_counters @post.id, :visited_count => 1
    end
    redirect_to posts_url if @post.nil?
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    respond_to do |format|
      if @post.destroy
        format.json { render_json_ok } 
      else
        format.json { render_json_fail } 
      end
    end
  end

  def date_posts
    # Client.where(:created_at => (Time.now.midnight - 1.day)..Time.now.midnight)
    # @posts = Post.where("DATE(created_at) = ?", params[:date]).paginate(page: params[:page])
    date = params[:date].to_date
    @posts = Post.where(:created_at => (date.yesterday..date.tomorrow)).paginate(page: params[:page])
  end
  
  def archives
    @posts_by_month = Post.find(:all, :order => "created_at DESC").group_by { |post| post.created_at.strftime("%B %Y")}
  end
  
  def month
    m = params[:m] + "-01"
    m = m.to_time
    logger.info "debug #{m}"
    @posts = Post.where(:created_at => (m.at_beginning_of_month .. m.at_end_of_month)).paginate(page: params[:page])
  end

  # def tag_posts
  #   @posts = Post.tag_with(params[:name])
  # end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    logger.debug "debug #{params}"
    if @post.update_attributes(params[:post])
      @post.update_tags(params[:tags])
      flash[:success] = "update success!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def search
    @posts = Post.search(params[:search])
  end

  def month_posts
    @posts = Post.search(params[:search])
  end
  


  protected
  
  def post_options
    {:only => [:content,:author,:visited_count,:comments_count,:date,:created_at,:type,:tags]}
  end

  # def user_options
  #   {:only => [:full_name]}
  # end
end
