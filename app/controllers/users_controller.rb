# encoding:utf-8
class UsersController < ApplicationController
  before_filter :logined ,:only=>[:new]
  before_filter :signed_in_user, :only=>[:edit,:update,:destroy]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
    render :layout => "home"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Woji App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "update success!"
      redirect_to @user
    else
      render 'edit'
    end
  end

end
