class EmailSubscribersController < ApplicationController
  skip_before_filter :ensure_authenticated, only: [:create]

  def create
    @email_subscriber = EmailSubscriber.new(email_address: params[:email_subscriber][:email_address])
    @email_subscriber.save!

    flash[:notice] = "Thanks! We'll keep you up to date."
    redirect_to root_path
  end
end
