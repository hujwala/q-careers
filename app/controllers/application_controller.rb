class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  ## This filter method is used to fetch current user
  before_filter :stylesheet_filename, :javascript_filename, :set_default_title, :current_user

  private

  def set_default_title
    set_title("Q-Careers")
  end

  def stylesheet_filename
    @stylesheet_filename = "application"
  end

  def javascript_filename
    @javascript_filename = "application"
  end

  # Method to redirect after successful authentication
  def redirect_to_appropriate_page_after_sign_in
    redirect_to users_dashboard_path if @current_user && !@current_user.token_expired?
    return
  end

end
