class SessionsController < ApplicationController

  def create
    auth = Authentication.authenticate(params[:email], params[:password])
    if auth.present?
      session[:authentication_id] = auth.id
      flash.notice = 'Welcome!'
      redirect_to :root
    else
      flash.now.alert = 'Invalid email/password combination.'
      render :new
    end
  end
end
