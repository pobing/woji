module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    # cookies[:login] = { :value => "XJ-122", :expires => 1.hour.from_now }
    if params[:session] && params[:session][:remember]
      cookies.permanent[:remember_token] = user.remember_token
    else
      cookies[:remember_token] = user.remember_token
    end
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
      @current_user ||= (login_from_session || login_from_cookie) unless @current_user == false
  end
  
  def login_from_session
     self.current_user = User.where(:id=>session[:user_id]).first if session[:user_id]
  end

  def login_from_cookie
    self.current_user = User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def sign_out
    session[:user_id] = nil
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end

  def current_user? user
    user == current_user
  end


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
end
