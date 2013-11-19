require 'spec_helper'

describe RootController do
  describe "#home" do
    context "when the user is logged in" do
      before { log_in authentications(:zoes_auth) }

      it 'redirects them to the welcome page' do
        get :home

        expect(response).to be_success
      end
    end

    context "when the user isn't logged in" do
      it 'redirects them to the welcome page' do
        get :home

        expect(response).to redirect_to welcome_path
      end
    end
  end
end
