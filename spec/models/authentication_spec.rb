require 'spec_helper'

describe Authentication do
  describe "has_secure_password" do
    it "does not allow the user to be saved without setting the password confirmation" do
      auth = Authentication.new(email: 'email@example.com', password: 'password')
      auth.should_not be_valid

      auth.password_confirmation = 'password'
      auth.should be_valid
    end
  end

  describe "before_create" do
    it "creates a new user" do
      auth = Authentication.new(email: 'email@example.com', password: 'pass', password_confirmation: 'pass')

      auth.user.should be_nil

      expect {
        auth.save
      }.to change { User.count }.by(1)

      auth.user.should be_present
    end
  end

  describe ".authenticate" do
    let(:email) { 'email@example.com' }
    let(:password) { 'Password123' }
    let!(:auth) do
      Authentication.create(email: email,
                            password: password,
                            password_confirmation: password)
    end

    context "when the right email/password is given" do
      it "returns the authentication" do
        Authentication.authenticate(email, password).should == auth
      end
    end

    context "when the wrong email/password is given" do
      it "returns the nothing" do
        Authentication.authenticate(email, 'offByALittle').should be_nil
      end
    end
  end
end
