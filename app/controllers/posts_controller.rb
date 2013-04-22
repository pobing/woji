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
  end

  def create
    @post = Post.new(params[:post])
    # @post.content =  add_auto_link(@post.content)

    # @post.tags = Tag.tags(params[:tags])
    @post.user_id = current_user.id
    if @post.save
      @post.update_tags(params[:tags])
      redirect_to posts_url
    else
      render action: "new"
    end
  end

  def post_tweet
    type = Post::Type::TWEET
    message = params[:message]
    attr = {:title => Post.tweet_title(message), :content => message, :item_type => type,:user_id => current_user.id}
    Post.create attr
    redirect_to posts_url
  end

  def post_blog
    type = Post::Type::TWEET
    attr = {:title => params[:title], :content => params[:message], :item_type => type,:user_id => current_user.id}
    post = Post.new(attr)
    if post.save
      post.update_tags(params[:tags])
      redirect_to posts_url
    else
      flash.now.alert = post.erros
      render action: "new"
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @post }
    # end
    redirect_to posts_url if @post.nil?
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url
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
  def tag_posts
    @posts = Post.tag_with(params[:name])
  end
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      @post.update_tags(params[:tags])
      flash[:success] = "update success!"
      redirect_to @post
    else
      render 'edit'
    end
  end 
end