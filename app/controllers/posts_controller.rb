class PostsController < ApplicationController
	def new
	  @post = Post.new
      # respond_to do |format|
      # format.html # new.html.erb
      # format.json { render json: @h }
    #end
	end
	def index
		@post = Post.all
	end

	def create
	  Rails.logger.debug "debug ------------- #{params}"
      @post = Post.new(params[:post])
      if @post.save
      	#redirect_to @post
      	redirect_to posts_url
      else
        render action: "new"
      end
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