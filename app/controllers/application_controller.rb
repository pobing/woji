# encoding:utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  helper_method :current_user

  
  def render_json_ok
    render :json => {:retCode => 1}
  end

  def render_json_fail
    render :json => {:retCode => 1}
  end

  private

  def current_user
    @current_user ||= User.find_by_remember_token( cookies[:auth_token]) if cookies[:auth_token]
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
