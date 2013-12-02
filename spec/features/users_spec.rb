require 'feature_helper'

describe "Signing up" do
  xit "allows the user to fill out personal information" do
    visit new_authentication_path

    fill_in "Email", with: 'zbarnacles@slugline.com'
    fill_in "Password", with: 'frankyPanky'
    fill_in "Password Confirmation", with: 'frankyPanky'
    click_button 'Sign Up'
    page.should have_content "Congratulations! You're awesome!"

    fill_in "Name", with: 'Zoe Barnes'
    fill_in "Phone number", with: '(518)334-6656'
    fill_in "Zip code", with: '11211'
    click_button 'Create User'
    page.should have_content "Welcome Zoe Barnes!"
  end
end
