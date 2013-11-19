require 'feature_helper'

describe "Creating a campaign" do
  let(:gillian) { users(:gillian) }
  let(:clear_water_initiative) { gillian.organizations.first }

  it "associates the user that creates the organization with the organization" do
    log_in_as gillian
    visit organization_path(clear_water_initiative)
    click_link "Create a new campaign"

    fill_in "Name", with: "Down with the Underwoods"
    fill_in "Description", with: "Claire Underwood is evil. Who knows about Frank? And Carrie Underwood just sucks."
    click_button 'Create Campaign'
    page.should have_content 'Successfully created a new campaign'

    page.should have_content clear_water_initiative.name
    page.should have_content "Down with the Underwoods"
    page.should have_content "Claire Underwood is evil. Who knows about Frank? And Carrie Underwood just sucks."
  end
end
