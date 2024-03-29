require 'spec_helper'

describe Authentication do
  describe "has_secure_password" do
    it "does not allow the user to be saved without setting the password confirmation" do
      auth = Authentication.new(email: 'email@example.com', password: 'password', password_confirmation: '')
      auth.should_not be_valid

      auth.password_confirmation = 'password'
      auth.should be_valid
    end
  end

  describe "validations" do
    let(:older_authentication) { FactoryGirl.create(:authentication) }
    it { should have_valid(:email).when('completelyRandom2132@horseshoePlantain.com') }
    it { should_not have_valid(:email).when(older_authentication.email, nil) }
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
