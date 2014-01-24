class RootController < ApplicationController
  skip_before_filter :ensure_authenticated, except: [:home]
  layout "splash"

  def welcome
  end

  def home
    render 'home', layout: 'application'
  end

  def effective
    render 'effective', layout: false
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
    @email_subscriber = EmailSubscriber.new
    render 'dear_internet'
  end

  def supporters
    @email_subscriber = EmailSubscriber.new
    render 'supporter_splash'
  end

  def organizers
    @email_subscriber = EmailSubscriber.new
    render 'organizer_splash'
  end


  private

  def ensure_authenticated
    redirect_to organizers_path unless logged_in?
  end
end
