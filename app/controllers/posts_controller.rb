class PostsController < ApplicationController
	def new
	  @post = Post.new
      # respond_to do |format|
      # format.html # new.html.erb
      # format.json { render json: @h }
    #end
	end
	def index
		Rails.logger.debug "debug ------------- #{params}"
		@post = if params[:type]
			Post.where(:item_type => params[:type].to_i)
		else
			Post.all
		end
	end

	def create
	  Rails.logger.debug "debug ------------- #{params}"
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
		Rails.logger.debug "debug ----post_message--------- #{params}"
        attr = {:title => Post.tweet_title(params[:message]), :content => params[:message],:item_type => type}
        Post.create attr
        redirect_to posts_url
	end
	
	def show
      @post = Post.find(params[:id])
      respond_to do |format|
      	format.html # show.html.erb
      	format.json { render json: @h }
      end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_url
	end
end