class UsersController < ApplicationController
  skip_before_filter :ensure_logged_in, only: [:new, :create]
  before_filter :ensure_authenticated

  def new
    @user = User.new
  end

end
