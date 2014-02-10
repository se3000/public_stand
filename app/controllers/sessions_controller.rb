class SessionsController < ApplicationController

  def create
    auth = Authentication.authenticate(params[:email], params[:password])
    if auth.present?
      session[:authentication_id] = auth.id
      flash.notice = 'Welcome!'
      redirect_to post_login_path
    else
      flash.now.alert = 'Invalid email/password combination.'
      render :new
    end
  end

  def destroy
    session[:authentication_id] = nil
    flash.notice = 'You have successfully logged out.'
    redirect_to :welcome
  end


  private

  def post_login_path
    organizations = current_user.organizations
    if organizations.one?
      organization_path(organizations.first)
    else
      root_path
    end
  end
end
