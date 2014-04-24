require 'feature_helper'

describe "Creating a campaign" do
  let(:gillian) { users(:gillian) }
  let(:doug) { users(:doug) }
  let(:clear_water_initiative) { gillian.organizations.first }
  let(:clear_water_campaign) { clear_water_initiative.campaigns.first }

  it "associates the user that creates the organization with the organization" do
    log_in_as gillian
    expect(current_url).to eq("http://#{clear_water_initiative.vanity_string}.lvh.me:#{ENV['PORT']}/")
    click_link "Create a new campaign"

    fill_in "backup-tweet-text", with: "Down with the Underwoods"
    fill_in "Description", with: "Claire Underwood is evil. Who knows about Frank? And Carrie Underwood just sucks."
    fill_in "Vanity String", with: "down-with-underwood"
    fill_in "Target Name", with: "Claire Underwood"
    fill_in "Phone Number", with: "(123)456-7890"
    fill_in "Talking Points", with: "Hey Claire,\n\nShut it!\n\n\nLove,\n{{your name here}}"
    click_button 'Create Campaign'
    page.should have_content 'Successfully created a new campaign'

    page.should have_content clear_water_initiative.name
    page.should have_content "Down with the Underwoods"
    page.should have_content "Claire Underwood is evil. Who knows about Frank? And Carrie Underwood just sucks."
    page.should have_content "Call from your computer"
    page.should have_content "Hey Claire,\n\nShut it!\n\n\nLove,\n{{your name here}}"
  end

  it "does not allow other users to edit the campaign" do
    log_in_as gillian
    click_link clear_water_campaign.name
    click_link 'Edit Campaign'

    fill_in "campaign[name]", with: "The Underwoods are killing America!"
    click_button 'Update Campaign'
    page.should have_content "Campaign successfully updated"
    page.should have_content "The Underwoods are killing America!"
    log_out

    log_in_as doug
    visit campaign_vanity(clear_water_campaign)
    page.should_not have_link 'Edit Campaign'
  end
end
