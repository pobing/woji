class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = if params[:type]
      Post.where(:item_type => params[:type].to_i)
      else
        Post.paginate(page: params[:page])
      end
  end

  def create
    @post = Post.new(params[:post])
    @post.tags = Tag.tags(params[:tags])
    if @post.save
      redirect_to posts_url
    else
      render action: "new"
    end
  end

  def post_tweet
    type = Post::Type::TWEET
    attr = {:title => Post.tweet_title(params[:message]), :content => params[:message], :item_type => type}
    Post.create attr
    redirect_to posts_url
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
end