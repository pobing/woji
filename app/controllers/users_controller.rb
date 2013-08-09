# encoding:utf-8
class UsersController < ApplicationController
  before_filter :logined ,:only=>[:new]
  before_filter :signed_in_user, :only=>[:edit,:update,:destroy]
  before_filter :set_user, :except => [:new,:create]
  
  def new
    @user = User.new
    render :layout => "home"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Woji App!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @posts = @user.posts.paginate(page: params[:page])
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "update success!"
      render 'edit'
    else
      render 'edit'
    end
  end

  def update_avatar
    flag = current_user? @user
    @user.avatar = params[:avatar] if flag && params[:avatar]
    if @user.save(:validate=>false)
      flash[:success] = "upload success!"
      render 'edit'
    else
      flash.now.alert = "upload failure"
      render 'edit'
    end
  end

  
  def remove_avatar
    user = User.find_by_id(params[:id])
    user.remove_avatar!
    if user.save!
      flash[:success] ="remove success!"
      render 'edit'
    else
      flash.now.alert = "upload failure"
      render 'edit'
    end
  end

  def download_avatar
    user = User.find_by_id(params[:id])
    path = "#{Rails.root}/public"+user.avatar_url(:original)
    send_file path , :filename=> user.avatar.filename
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.json { render_json_ok }
      else
        format.json { render_json_fail }
      end
    end
  end
  
  private

  def set_user
    @user = User.find_by_id(params[:id])
  end
end
