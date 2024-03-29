class AuthenticationsController < ApplicationController

  def new
    @authentication = Authentication.new
  end

  def create
    @authentication = Authentication.new(Params.clean params)
    if @authentication.save
      @authentication.create_user
      flash[:notice] = "Congratulations! You're awesome!"
      session[:authentication_id] = @authentication.id
      redirect_to :root
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
