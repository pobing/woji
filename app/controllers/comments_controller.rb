class CommentsController < ApplicationController
  def create
    @post = Post.find_by_id(params[:post_id])
    commenter = current_user if current_user
    if params[:user]
      user = User.new(params[:user])
      user.save(:validate=>false)
      user.send_acitve_mail
      commenter = user
    end
    attr = {:content => params[:comment][:content],:user_id => commenter.id }
    if @post && @post.comments.create(attr)
      redirect_to post_path(@post)
    else
      render :json=>{retCode: 0 }
    end
  end

  def destroy
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post) 
  end
end
