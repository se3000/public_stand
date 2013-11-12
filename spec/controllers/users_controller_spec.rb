require 'spec_helper'

describe UsersController do
  describe "#new" do
    before { log_in authentications(:zoe) }

    it "builds a new instance of user" do
      get :new

      user = assigns(:user)
      expect(user).to be_a User
      expect(user).to be_new_record

      response.should render_template :new
    end
  end
end
