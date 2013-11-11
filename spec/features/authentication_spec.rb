require 'spec_helper'

describe "Logging in" do
  it "allows the user to create a new login" do
    visit new_authentication_path

    fill_in "Email Address", with: 'zbarnes@slugline.com'
    fill_in "Password", with: 'frankyPanky'
    fill_in "Password Confirmation", with: 'frankyPanky'
    click_button 'Sign Up'

    page.should have_content "Congratulations! You're awesome!"
  end
end
