class RootController < ApplicationController
  layout "splash"

  def home
    if logged_in?
      render 'home', layout: 'application'
    else
      @email_subscriber = EmailSubscriber.new
      render 'organizer_splash'
    end
  end

  def dear_internet
    @email_subscriber = EmailSubscriber.new
    render 'dear_internet'
  end
end
