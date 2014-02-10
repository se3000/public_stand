require 'feature_helper'

describe "Logging in" do
  before do
    authentication = Authentication.create({
                       email: 'zbarnacles@slugline.com',
                       password: 'frankyPanky',
                       password_confirmation: 'frankyPanky'})
    authentication.create_user
  end

  it "allows the user to create a new login" do
    visit login_path

    fill_in "Email", with: 'zbarnacles@slugline.com'
    fill_in "Password", with: 'frankyPanky'
    click_button 'Log In'

    page.should have_content "Welcome!"
  end
end

describe "Signing up" do
  it "allows the user to create a new login" do
    visit new_authentication_path

    fill_in "Email", with: 'zbarnacles@slugline.com'
    fill_in "Password", with: 'frankyPanky'
    fill_in "Password Confirmation", with: 'frankyPanky'
    click_button 'Sign Up'
    page.should have_content "Congratulations! You're awesome!"

    page.should have_content "You aren't a part of any organizations. Create a new organization"
  end
end

describe "Logging out" do
  it "allows a user to no longer be signed in" do
    visit root_path
    page.should_not have_content "Log Out"

    log_in_as authentications(:zoes_auth)
    visit root_path
    page.should have_content "Log Out"

    click_link "Log Out"
    page.should have_content "successfully logged out"
    page.should_not have_content "Log Out"
  end
end
