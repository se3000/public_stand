class AuthenticationsController < ApplicationController
  skip_before_filter :ensure_logged_in, only: [:new, :create]

  def new
    @authentication = Authentication.new
  end

  def create
    @authentication = Authentication.new(Params.clean params)
    if @authentication.save
      flash[:notice] = "Congratulations! You're awesome!"
      session[:authentication_id] = @authentication.id
      redirect_to new_user_path
    else
      render :new
    end
  end

  class Params
    def self.clean paramaters
      paramaters.require(:authentication).permit(:email, :password, :password_confirmation)
    end
  end
end
