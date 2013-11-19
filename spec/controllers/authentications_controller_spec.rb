require 'spec_helper'

describe AuthenticationsController do
  describe "#new" do
    it "creates a new instance of Authentication" do
      get :new
      auth = assigns(:authentication)
      auth.should be_a Authentication
      auth.should be_new_record
    end
  end

  describe "#create" do
    let(:authentication_params) { {email: 'zbarnes@slugline', password: 'frankNbeans', password_confirmation: 'frankNbeans'} }

    it "creates a new instance of Authentication" do
      expect {
        post :create, authentication: authentication_params
      }.to change { Authentication.count }.by(+1)
    end

    it "creates a new instance of User" do
      expect {
        post :create, authentication: authentication_params
      }.to change { User.count }.by(+1)
    end

    it 'redirects to a new instance of Authentication' do
      post :create, authentication: authentication_params

      response.should be_redirect
      auth = assigns(:authentication)
      auth.should be_a Authentication
      auth.should be_persisted
    end

    context "when the Authorization is not valid" do
      let(:authentication_params) { {email: 'zbarnes@slugline', password: 'frankNbeans', password_confirmation: ''} }

      it "renders the new page" do
        post :create, authentication: authentication_params
        response.should render_template :new
      end

      it "does not save the new authentication" do
        expect {
          post :create, authentication: authentication_params
        }.not_to change { Authentication.count }

        auth = assigns(:authentication)
        auth.should be_a Authentication
        auth.should be_new_record
      end
    end
  end
end

describe "AuthenticationsController::Params" do
  describe ".clean" do
    it "removes everything other than email, password, and password_confirmation" do
      params = ActionController::Parameters.new(authentication: {
          name: 'Uneccesary',
          email: 'email@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        },
        otro: "Woah, no."
      )

      cleaned = AuthenticationsController::Params.clean(params)

      expect(cleaned).to eq({email: 'email@example.com', password: 'pass', password_confirmation: 'pass'}.with_indifferent_access)
    end
  end
end
