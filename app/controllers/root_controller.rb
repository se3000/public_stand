class RootController < ApplicationController
  skip_before_filter :ensure_authenticated, only: [:welcome]

  def welcome
  end

  def home
  end


  private

  def ensure_authenticated
    redirect_to welcome_path unless logged_in?
  end
end
