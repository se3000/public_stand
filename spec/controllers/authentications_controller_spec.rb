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
end
