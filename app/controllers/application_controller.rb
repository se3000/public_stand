class ApplicationController < ActionController::Base
  include RoutesHelper

  protect_from_forgery with: :exception

  before_filter :sanitize_for_cancan

  helper_method :current_user, :logged_in?
  helper_method :organization_vanity, :campaign_vanity, :vanity_options, :subdomain, :host

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_url(subdomain: nil)
  end

  private

  def ensure_authenticated
    unless logged_in?
      flash.alert = "You must be logged in to access this page"
      redirect_to login_url
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

  def logged_out?
    !logged_in?
  end

  def sanitize_for_cancan #https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

end
