require 'spec_helper'

describe "Logging in" do
  it "allows the user to create a new login" do
    visit sign_up_path

    fill_in "Email Address", with: 'zbarnes@slugline.com'
    fill_in "Password", with: 'frankyPanky'
    fill_in "Password Confirmation", with: 'frankyPanky'
    click_button 'Sign Up'
    page.should have_content "Congratulations! You're awesome!"

    page.should have_content "Welcome!"
    fill_in "First Name", with: 'Zooey'
    fill_in "Last Name", with: 'Barnes'
    fill_in "Company", with: 'Slugline'
    fill_in "Phone Number", with: '(518)334-6656'
    fill_in "Zip Code", with: '11211'
    click_button 'Save'
  end
end
