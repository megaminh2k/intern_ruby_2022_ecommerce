module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user? user
    user && user == current_user
  end

  def logged_in?
    current_user.present?
  end

  def admin_logged_in?
    current_user.present? && current_user.Admin?
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def redirect_back_or default
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
