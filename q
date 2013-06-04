[1mdiff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb[m
[1mindex 656b6db..e8adfc9 100644[m
[1m--- a/app/controllers/application_controller.rb[m
[1m+++ b/app/controllers/application_controller.rb[m
[36m@@ -2,7 +2,7 @@[m
 class ApplicationController < ActionController::Base[m
   protect_from_forgery[m
   include SessionsHelper[m
[31m-  helper_method :current_user[m
[32m+[m[32m  # helper_method :current_user[m
 [m
   [m
   def render_json_ok[m
[36m@@ -13,11 +13,4 @@[m [mclass ApplicationController < ActionController::Base[m
     render :json => {:retCode => 1}[m
   end[m
 [m
[31m-  private[m
[31m-[m
[31m-  def current_user[m
[31m-    @current_user ||= User.find_by_remember_token( cookies[:auth_token]) if cookies[:auth_token][m
[31m-    # @current_user ||= User.find(session[:user_id]) if session[:user_id][m
[31m-  end[m
[31m-[m
 end[m
[1mdiff --git a/app/controllers/sessions_controller.rb b/app/controllers/sessions_controller.rb[m
[1mindex 18f9162..12e9d08 100644[m
[1m--- a/app/controllers/sessions_controller.rb[m
[1m+++ b/app/controllers/sessions_controller.rb[m
[36m@@ -9,14 +9,7 @@[m [mclass SessionsController < ApplicationController[m
   def create[m
     user = User.find_by_email(params[:session][:email]) || User.find_by_login(params[:session][:email])[m
     if user && user.authenticate(params[:session][:password])[m
[31m-      # sign_in user[m
[31m-      if params[:remember_me][m
[31m-        # generate_token[m
[31m-        cookies.permanent[:remember_token] = user.remember_token[m
[31m-      else[m
[31m-        cookies[:remember_token] = user.remember_token[m
[31m-      end[m
[31m-      # session[:user_id] = user.id[m
[32m+[m[32m      sign_in user[m
       redirect_back_or root_url[m
     else[m
       flash.now.alert = 'Invalid email/password combination' [m
[36m@@ -25,8 +18,8 @@[m [mclass SessionsController < ApplicationController[m
   end[m
 [m
   def destroy[m
[31m-    # sign_out[m
[31m-    session[:user_id] = nil[m
[31m-    redirect_to home_path[m
[32m+[m[32m    sign_out[m
[32m+[m[32m    # session[:user_id] = nil[m
[32m+[m[32m    # redirect_to home_path[m
   end[m
 end[m
[1mdiff --git a/app/helpers/sessions_helper.rb b/app/helpers/sessions_helper.rb[m
[1mindex f3412b4..8ef7096 100644[m
[1m--- a/app/helpers/sessions_helper.rb[m
[1m+++ b/app/helpers/sessions_helper.rb[m
[36m@@ -3,30 +3,28 @@[m [mmodule SessionsHelper[m
   def sign_in(user)[m
     cookies.permanent[:remember_token] = user.remember_token[m
     # cookies[:login] = { :value => "XJ-122", :expires => 1.hour.from_now }[m
[31m-    Rails.logger.debug "debug ===== #{user}"[m
[31m-    # cookies[:remember_token] = user.remember_token[m
[32m+[m[32m    if params[:remember_me][m
[32m+[m[32m      cookies.permanent[:remember_token] = user.remember_token[m
[32m+[m[32m    else[m
[32m+[m[32m      cookies[:remember_token] = user.remember_token[m
[32m+[m[32m    end[m
     self.current_user = user[m
[31m-    # session[:user_id] = user.id[m
   end[m
 [m
   def signed_in?[m
     !current_user.nil?[m
[31m-    # !session[:user_id].nil?[m
   end[m
 [m
   def current_user=(user)[m
[31m-    Rails.logger.debug "1111111"[m
     @current_user = user[m
   end[m
 [m
   def current_user[m
[31m-    Rails.logger.debug "2222"[m
     @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token][m
   end[m
 [m
   def sign_out[m
[31m-    # self.current_user = nil[m
[31m-    session[:user_id] = nil[m
[32m+[m[32m    self.current_user = nil[m
     cookies.delete(:remember_token)[m
   end[m
   [m
[1mdiff --git a/app/models/user.rb b/app/models/user.rb[m
[1mindex 38285b6..3aa19d7 100644[m
[1m--- a/app/models/user.rb[m
[1m+++ b/app/models/user.rb[m
[36m@@ -25,7 +25,7 @@[m [mclass User < ActiveRecord::Base[m
   has_many :comments[m
   belongs_to :disk_file , :foreign_key=>"avatar_id"[m
   before_save { |user| user.email= email.downcase if email}[m
[31m-  # before_save { generate_token(:remember_token) }[m
[32m+[m[32m  before_save { generate_token(:remember_token) }[m
   mount_uploader :avatar, Uploader[m
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i[m
   validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},[m
[1mdiff --git a/app/views/layouts/_header.html.erb b/app/views/layouts/_header.html.erb[m
[1mindex 7dba054..7f23a7a 100644[m
[1m--- a/app/views/layouts/_header.html.erb[m
[1m+++ b/app/views/layouts/_header.html.erb[m
[36m@@ -2,7 +2,7 @@[m
   <div class="top">[m
     <h3 class="muted"><%=link_to "我记 - I rember",root_path %></h3>[m
    <!--  <h5>随身随地记你需要记的...</h5> -->[m
[31m-    <% if current_user %>[m
[32m+[m[32m    <% if signed_in? %>[m
       <ul class="nav nav-pills pull-right">[m
         <li><%=link_to (image_tag(current_user.small_avatar)),current_user %></li>[m
         <li><%= link_to current_user.full_name, current_user %></li>[m
