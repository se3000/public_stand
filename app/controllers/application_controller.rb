class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :ensure_logged_in

  helper_method :current_user


  private

  def ensure_logged_in
    flash.alert = "You must be logged in to access this page"
    redirect_to :root unless current_user
  end

  def ensure_authenticated
    flash.alert = "You must be logged in to access this page"
    redirect_to :root unless session[:authentication_id]
  end

  def current_user
    return @current_user if @current_user
    if session[:authentication_id]
      @current_user = Authentication.find(session[:authentication_id]).user
    end
  end
end
