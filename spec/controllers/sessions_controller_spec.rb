require 'spec_helper'

describe SessionsController do
  describe "#create" do
    let(:authentication) { authentications(:zoes_auth) }
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

        expect(session[:authentication_id]).to eq authentication.id
      end

      context "when the user has a single organization" do
        let(:organization) { FactoryGirl.create(:organization) }

        before do
          authentication.user.memberships.create(organization: organization)
        end

        it "redirects to the organization page" do
          post :create, email: email, password: password

          expect(response).to redirect_to organization_path(organization)
        end
      end

      context "when the user doesnot have 1 organization" do
        let(:authentication) do
          FactoryGirl.create(:authentication).tap do |auth|
            auth.create_user
          end
        end

        it "redirects to the root page" do
          post :create, email: email, password: password

          expect(response).to redirect_to root_path
        end
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
        expect(session[:authentication_id]).to be_nil
      end
    end
  end

  describe "#destroy" do
    before { session[:authentication_id] = authentications(:zoes_auth) }

    it "removes any stored session_id" do
      expect(session[:authentication_id]).to be_present

      get :destroy

      expect(session[:authentication_id]).to be_nil
    end

    it "redirects to root" do
      get :destroy

      expect(response).to redirect_to welcome_path
    end
  end
end
