class SessionsController < ApplicationController
  layout "reg"

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # sign_in user
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:error] = 'Invalid email/password combination'
      render "new"
    end
  end

  def destroy
    #sign_out
    session[:user_id] = nil
    redirect_to home_path
  end
end
