require 'spec_helper'

describe UsersController do
  describe "#new" do
    before { log_in authentications(:zoes_auth) }

    it "builds a new instance of user" do
      get :new

      user = assigns(:user)
      expect(user).to be_a User
      expect(user).to be_new_record

      response.should render_template :new
    end
  end

  describe "#create" do
    let(:authentication) { FactoryGirl.create(:authentication) }
    let(:user_params) { {name: "First Last"} }

    before { log_in authentication }

    context "when the user is valid" do
      it "creates a user" do
        authentication.user.should be_nil

        expect {
          post :create, user: user_params
        }.to change { User.count }.by(+1)

        authentication.reload.user.should be_present
        response.should be_redirect
      end
    end

    context "when the user is invalid" do
      before { User.any_instance.should_receive(:save).and_return(false) }

      it "does not create a user" do
        expect {
          post :create, user: user_params
        }.not_to change { User.count }
        response.should render_template :new
      end
    end
  end
end

describe "UsersController::Params" do
  describe ".clean" do
    it "removes everything other than email, password, and password_confirmation" do
      params = ActionController::Parameters.new(user: {
          name: 'First Last',
          first_name: 'Unneeded',
          last_name: 'Unnecessary',
          zip_code: '11111',
          phone_number: "(555)555-5555"
        },
        otro: "Woah, no."
      )

      cleaned = UsersController::Params.clean(params)

      expect(cleaned).to eq({
        name: 'First Last',
        zip_code: '11111',
        phone_number: '(555)555-5555'}.with_indifferent_access)
    end
  end
end
