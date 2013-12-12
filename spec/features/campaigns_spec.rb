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
    fill_in "Target Name", with: "Claire Underwood"
    fill_in "Phone Number", with: "(123)456-7890"
    fill_in "Script", with: "Hey Claire,\n\nShut it!\n\n\nLove,\n{{your name here}}"
    click_button 'Create Campaign'
    page.should have_content 'Successfully created a new campaign'

    page.should have_content clear_water_initiative.name
    page.should have_content "Down with the Underwoods"
    page.should have_content "Claire Underwood is evil. Who knows about Frank? And Carrie Underwood just sucks."
    page.should have_content "Call Claire Underwood"
    page.should have_content "Hey Claire,\n\nShut it!\n\n\nLove,\n{{your name here}}"
  end
end
