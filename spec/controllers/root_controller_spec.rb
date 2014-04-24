require 'spec_helper'

describe RootController do
  describe "#home" do
    context "when the user is logged in" do
      let(:user) { users(:gillian) }
      before { log_in user.authentication }

      context "and has 1 organization" do
        let(:organization) { user.organizations.first }

        it 'redirects to the organization' do
          get :home

          expect(response).to redirect_to organization_vanity(organization)
        end
      end


      context "and does not have 1 organization" do
        before do
          user.organizations << FactoryGirl.create(:organization)
        end

        it 'renders the page' do
          get :home

          expect(response).to render_template 'home'
        end
      end
    end

    context "when the user isn't logged in" do
      it 'redirects them to the welcome page' do
        get :home

        expect(response).to render_template 'organizer_splash'
      end
    end
  end
end
