class UsersController < ApplicationController
  skip_before_filter :ensure_logged_in, only: [:new, :create]
  before_filter :ensure_authenticated

  def new
    @user = User.new
  end

  def create
    @user = current_auth.build_user(Params.clean(params))
    if @user.save
      flash.notice = "Welcome #{@user.first_name}!"
      redirect_to @user
    else
      flash.now.alert = @user.errors.full_messages
      render :new
    end
  end

  class Params
    def self.clean(params)
      params.require(:user)
        .permit(:first_name, :last_name, :zip_code, :phone_number)
    end
  end
end
