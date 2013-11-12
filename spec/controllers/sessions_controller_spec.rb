require 'spec_helper'

describe SessionsController do
  describe "#create" do
    let(:authentication) { authentications(:zoe) }
    let(:email) { authentication.email }
    let(:password) { authentication.password }

    context "when the user successfully authenticates" do
      before do
        Authentication.should_receive(:authenticate)
          .with(email, password)
          .and_return(authentication)
      end

      it "should redirect to the next page" do
        post :create, email: email, password: password
        response.should be_redirect
        expect(session[:user_id]).to eq authentication.user_id
      end
    end

    context "when the user fails to authenticate" do
      before do
        Authentication.should_receive(:authenticate)
          .with(email, password)
          .and_return(nil)
      end

      it "should redirect to the next page" do
        post :create, email: email, password: password
        response.should render_template 'sessions/new'
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
