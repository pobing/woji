# encoding:utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # def signed_in?
  # 	current_user
  # end

  def logined
    redirect_to root_path if signed_in? 
  end

  def set_current_user
  	User.current = current_user
  end

  def signed_in_user
  	unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sigin in"
  	end
  end
  
  def render_json_ok
    render :json => {:retCode => 1}
  end

  def render_json_fail
    render :json => {:retCode => 1}
  end
end
