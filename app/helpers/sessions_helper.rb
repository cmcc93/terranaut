module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to new_session_path, notice: "Please sign in."
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    flash[:success] = "Welcome, #{current_user.first_name}!"
    session.delete(:return_to)
  end

  def store_location
    # if current_user.id == nil
      session[:return_to] = request.url if request.get?
    # elsif current_user.id == !nil
      # session[:return_to] = request.url(:id => current_user.id)
    # end
  end
  
end