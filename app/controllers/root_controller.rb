class RootController < ApplicationController
  skip_before_filter :ensure_logged_in, only: [:welcome]

  def welcome
  end
end
