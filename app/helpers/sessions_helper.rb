module SessionsHelper
  def sign_in(user)
    #cookies.permanent[:remember_token] = user.remember_token
    # cookies[:login] = { :value => "XJ-122", :expires => 1.hour.from_now }

    cookies[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def sign_out
    Rails.logger.debug "debug selfc1 #{self.current_user.id}"
    self.current_user = nil
    Rails.logger.debug "debug self cookies ,#{cookies},#{cookies[:remember_token]}"
    cookies.delete(:remember_token)
  end

end
