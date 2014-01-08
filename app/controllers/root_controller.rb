class RootController < ApplicationController
  skip_before_filter :ensure_authenticated, except: [:home]

  def welcome
  end

  def home
  end

  def effective
    render 'effective', layout: false
  end

  def organizer
    render 'organizer', layout: false
  end

  def lobbyist
    render 'lobbyist', layout: false
  end

  def splash
    render 'splash', layout: false
  end

  def stand
    render 'stand', layout: false
  end

  def dear_internet
    render 'dear_internet', layout: false
  end

  def full_width
    render 'full-width', layout: false
  end


  private

  def ensure_authenticated
    redirect_to welcome_path unless logged_in?
  end
end
