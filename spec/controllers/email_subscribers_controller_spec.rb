require 'spec_helper'

describe EmailSubscribersController do
  describe "#create" do
    context "when the subscriber is valid" do
      before { EmailSubscriber.any_instance.stub(:save).and_return(true) }

      it "redirects to root with a positive message" do
        post :create, email_subscriber: { email_address: 'a@a.a' }

        expect(flash[:notice]).to eq("Thanks! We'll keep you up to date.")
        expect(response).to redirect_to root_path
      end
    end

    context "when the subscriber is invalid" do
      before { EmailSubscriber.any_instance.stub(:save).and_return(false) }

      it "redirects to the root with a negative message" do
        post :create, email_subscriber: { email_address: 'a@a.a' }

        expect(flash[:notice]).to eq("Thanks! We'll keep you up to date.")
        expect(response).to redirect_to root_path
      end
    end
  end
end
