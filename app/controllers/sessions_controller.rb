# encoding:utf-8
class SessionsController < ApplicationController
  before_filter :logined
  layout "home"

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email]) || User.find_by_login(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or root_url
    else
      flash.now.alert = 'Invalid email/password combination' 
      render "new"
    end
  end

  def github_auth
    Rails.logger.debug "debug #{auth_hash}"
    user = User.from_auth(auth_hash)
    if user
      # sign_in user
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.nick_name}"
      redirect_back_or root_url
    else
      flash.now.alert = 'auth fail .' 
      render "new"
    end
  end

  def weibo_auth
    Rails.logger.debug "debug #{request.env['omniauth.auth']}"
  end

  def destroy
    sign_out
    # session[:user_id] = nil
    # redirect_to home_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
