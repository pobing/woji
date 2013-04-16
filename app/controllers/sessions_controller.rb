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
      redirect_back_or root_url
    else
      flash.now.alert = 'Invalid email/password combination' 
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path
  end
end
