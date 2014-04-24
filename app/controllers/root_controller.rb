class RootController < ApplicationController
  layout "splash"

  def home
    if logged_out?
      @email_subscriber = EmailSubscriber.new
      render 'organizer_splash'
    elsif current_user.organizations.one?
      redirect_to organization_vanity(current_user.organizations.first)
    else
      render 'home', layout: 'application'
    end
  end

  def dear_internet
    @email_subscriber = EmailSubscriber.new
    render 'dear_internet'
  end
end
