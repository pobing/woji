class SessionsController < ApplicationController
  before_filter :logined
  layout "home"

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # sign_in user
      if params[:remember_me]
        cookies.permanent[:remember_token] = user.remember_token
      else
        cookies[:remember_token] = user.remember_token
      end
      # session[:user_id] = user.id
      # redirect_to root_url, :notice => "Logged in !"  
      redirect_back_or root_url,:notice => "Logged in !"
    else
      flash.now.alert = 'Invalid email/password combination' 
      # flash[:error] = 'Invalid email/password combination'
      render "new"
    end
  end

  def destroy
    #sign_out
    session[:user_id] = nil
    redirect_to home_path
  end
end
