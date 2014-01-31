class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  #method to let redactor wysiwig editors to know whether a user is logged in
  def redactor_authenticate_user!
    signed_in_user # devise before_filter
  end

  def redactor_current_user
    current_user # devise user helper
  end

  protected

  # this was skoglund's code
  def confirm_logged_in
    # unless session[:user_id]
    #   flash[:notice] = "Please log in."
    #   redirect_to(:controller => 'access', :action => 'login')
    #   return false
    # else
    #   return true
    # end
  end

  #########
  # this is my method to check if a user is the admin user
  # the method references the list of admin users above
  #########
  def check_whether_admin
    # unless session[:user_id] == 1
    #   flash[:notice] = "You are not permitted to perform that function."
    #   redirect_to(:controller => 'access', :action => 'login')
    #   return false
    # else
    #   return true
    # end
  end

end