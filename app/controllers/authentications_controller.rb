class AuthenticationsController < ApplicationController

  def new
    @authentication = Authentication.new
  end

  def create
    @authentication = Authentication.new(Params.clean params)
    if @authentication.save
      flash[:notice] = "Congratulations! You're awesome!"
      redirect_to new_authentication_path
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
