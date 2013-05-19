# encoding:utf-8
class Api::UsersController < ApplicationController
  before_filter :signed_in_user, :only=>[:update_pwd,:update_avatar]

  def update_pwd
  	user = User.find_by_id(params[:id])
  	flag = current_user? user
  	respond_to do |format|
    	if flag && user.authenticate(params[:old_password])
         attr = {password:params[:password],password_confirmation:params[:password_confirmation]}
         if user.update_attributes attr
         	format.json { render :json=>{:retCode=>1,:msg=>"update success!"}}
         end
    	else
    		format.json { render :json=>{:retCode=>0,:errors=>"old_password is not correct!"}}
    	end
    end
  end

  def update_avatar
    Rails.logger.debug "debug params #{params}"
    user = User.find_by_id(params[:id])
    flag = current_user? user
    user.avatar = params[:avatar] if flag && params[:avatar]
    if user.save(:validate=>false)
      flash[:success] = "upload success!"
      redirect_to "/users/#{params[:id]}/edit"
    else
      flash.now.alert = "upload failure"
      # redirect_to user_edit_path
    end
    # respond_to do |format|
    #   if user.save(:validate=>false)
    #     format.json { render :json=>{:retCode=>1,:msg=>"update success!",:item => user.avatar}}
    #   else
    #     format.json { render :json=>{:retCode=>0,:errors=>"old_password is not correct!"}}
    #   end
    # end
  end

end