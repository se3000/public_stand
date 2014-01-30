require 'spec_helper'

describe RootController do
  describe "#home" do
    context "when the user is logged in" do
      before { log_in authentications(:zoes_auth) }

      it 'renders the page' do
        get :home

        expect(response).to be_success
        expect(response).to render_template 'home'
      end
    end

    context "when the user isn't logged in" do
      it 'redirects them to the welcome page' do
        get :home

        expect(response).to be_success
        expect(response).to render_template 'organizer_splash'
      end
    end
  end
end
