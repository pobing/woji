# encoding:utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  # helper_method :current_user

  
  def render_json_ok
    render :json => {:retCode => 1}
  end

  def render_json_fail
    render :json => {:retCode => 1}
  end

end
