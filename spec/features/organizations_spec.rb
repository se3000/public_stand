require 'feature_helper'

describe "Creating an organization" do
  let(:user) { users(:zoe) }

  it "associates the user that creates the organization with the organization" do
    log_in_as user
    page.should have_content "You aren't a part of any organizations. Create a new organization"
    click_link "Create a new organization"

    fill_in "Name", with: "Politicians Unsettled by Scandal(the tv show)"
    fill_in "Description", with: "We've had enough."
    click_button "Create Organization"
    page.should have_content "Successfully created new organization"
  end
end

describe "Viewing an organization" do
  let(:gillian) { users(:gillian) }
  let(:clear_water_initiative) { gillian.organizations.first }
  let(:clear_water_campaign) { clear_water_initiative.campaigns.first }

  it "associates the user that creates the organization with the organization" do
    log_in_as gillian

    page.should have_content clear_water_initiative.name
    page.should have_content clear_water_initiative.description

    page.should have_content "Campaigns:"
    page.should have_content clear_water_campaign.name
  end
end

describe "Editing an organization" do
  let(:doug) { users(:doug) }
  let(:gillian) { users(:gillian) }
  let(:clear_water_initiative) { gillian.organizations.first }
  let(:clear_water_campaign) { clear_water_initiative.campaigns.first }

  it "members of the organization can edit the organization" do
    log_in_as gillian
    visit organization_path(clear_water_initiative)
    page.should have_content clear_water_initiative.description

    click_link 'Edit'
    fill_in "Description", with: "Where is SSN 2 when you need it?"
    click_button 'Update Organization'

    page.should have_content "Successfully updated organization"
    page.should have_content "Where is SSN 2 when you need it?"
    log_out
  end

  it "visitors cannot edit the organization" do
    visit organization_path(clear_water_initiative)
    page.should have_content clear_water_initiative.description
    page.should_not have_link 'Edit'
  end

  it "non-members cannot edit the organization" do
    log_in_as doug
    visit organization_path(clear_water_initiative)
    page.should have_content clear_water_initiative.description
    page.should_not have_link 'Edit'
  end
end
