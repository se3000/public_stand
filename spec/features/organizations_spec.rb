require 'feature_helper'

describe "Creating an organization" do
  let(:user) { users(:zoe) }

  it "associates the user that creates the organization with the organization" do
    log_in_as user
    page.should have_content "You aren't a part of any organizations. Create an organization"
    click_link "Create an organization"

    fill_in "Name", with: "Politicians Unsettled by Scandal(the tv show)"
    fill_in "Description", with: "We've had enough."
    click_button "Create Organization"
    page.should have_content "Successfully created new organization"
  end
end

describe "Viewing an organization" do
  let(:gillian) { users(:gillian) }
  let(:clear_water_initiative) { gillian.organizations.first }

  it "associates the user that creates the organization with the organization" do
    log_in_as gillian

    page.should have_content clear_water_initiative.name
    page.should have_content clear_water_initiative.description
    click_link clear_water_initiative.name
  end
end
