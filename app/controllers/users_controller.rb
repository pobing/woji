class UsersController < ApplicationController
  before_filter :logined ,:only=>[:new]
  before_filter :signed_in_user, :only=>[:update,:destroy]
  def new
    @user = User.new
    render :layout => "home"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
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
