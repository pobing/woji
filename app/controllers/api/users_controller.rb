# encoding:utf-8
class Api::UsersController < ApplicationController
  before_filter :signed_in_user, :only=>[:update,:destroy]
  def update_pwd
  	Rails.logger.debug "debug ========= #{params}"
  	user = User.find_by_id(params[:id])
  	flag = current_user? user
  	
  	if flag && user.authenticate(params[:old_password])
       attr = {password:params[:password],password_confirmation:params[:password_confirmation]}
       if user.update_attributes attr
       	render :json=>{:retCode=>1,:msg=>"update success!"}
       end
  	else
  		render :json=>{:retCode=>0,:msg=>"old old_password is not correct!"}
  	end
  end
end