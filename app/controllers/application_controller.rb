class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :ensure_logged_in

  helper_method :current_user


  private

  def ensure_logged_in
    unless current_user.present?
      flash.alert = "You must be logged in to access this page"
      redirect_to :root
    end
  end

  def ensure_authenticated
    unless current_auth.present?
      flash.alert = "You must be logged in to access this page"
      redirect_to new_user_path
    end
  end

  def current_user
    @current_user ||= current_auth.user if current_auth
  end

  def current_auth
    if session[:authentication_id]
      Authentication.find(session[:authentication_id])
    end
  end
end
