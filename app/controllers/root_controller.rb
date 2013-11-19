class RootController < ApplicationController
  skip_before_filter :ensure_authenticated, only: [:welcome]

  def welcome
  end

  def home
  end
end
