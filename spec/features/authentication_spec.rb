require 'spec_helper'

describe "Logging in" do
  before do
    Authentication.create(email: 'zbarnes@slugline.com',
                          password: 'frankyPanky',
                          password_confirmation: 'frankyPanky')
  end

  it "allows the user to create a new login" do
    visit login_path

    fill_in "Email", with: 'zbarnes@slugline.com'
    fill_in "Password", with: 'frankyPanky'
    click_button 'Log In'

    page.should have_content "Welcome!"
  end
end

describe "Signing up" do
  it "allows the user to create a new login" do
    visit new_authentication_path

    fill_in "Email Address", with: 'zbarnes@slugline.com'
    fill_in "Password", with: 'frankyPanky'
    fill_in "Password Confirmation", with: 'frankyPanky'
    click_button 'Sign Up'

    page.should have_content "Congratulations! You're awesome!"
  end
end
