require 'spec_helper'

describe Authentication do
  describe "#password_digest" do
    it "does not allow the user to be saved without setting the password confirmation" do
      auth = Authentication.new(email: 'email@example.com', password: 'password')
      auth.should_not be_valid

      auth.password_confirmation = 'password'
      auth.should be_valid
    end
  end
end
