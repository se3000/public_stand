require 'feature_helper'

describe "Creating an organization" do
  let(:user) { users(:zoe) }

  it "associates the user that creates the organization with the organization" do
    log_in_as user
    page.should have_content "You aren't a part of any organizations. Create an organization"
    click_link "Create an organization"

    fill_in "Name", with: "Reporters Against Political Extortion"
    fill_in "Description", with: "We've had enough."
    click_button "Create Organization"
    page.should have_content "Successfully created new organization"
  end
end
