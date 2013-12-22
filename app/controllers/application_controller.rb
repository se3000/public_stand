class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :ensure_authenticated

  helper_method :current_user, :logged_in?


  private

  def ensure_authenticated
    unless logged_in?
      flash.alert = "You must be logged in to access this page"
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= current_auth.user if current_auth
  end

  def current_auth
    @current_auth ||= Authentication.find_by_id(session[:authentication_id])
  end

  def logged_in?
    current_auth.present?
  end
end
