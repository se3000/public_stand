require 'feature_helper'

describe "Calling" do
  let(:user) { users(:gillian) }
  let(:organization) { user.organizations.first }
  let(:campaign) { organization.campaigns.first }
  let(:target) { campaign.targets.first }

  it "calls the user", twilio: true, js: true do
    visit campaign_vanity(campaign)

    click_link "Call from your phone"
    fill_in "Your Phone Number", with: '5183346656'
    click_button 'Call Me'

    page.should have_content "Don't know what to say?"
    click_link "I've completed the call..."

    page.should have_content "How did the call go?"
    click_link "Skip"

    page.should have_content "Tell your friends to support the cause"
  end
end
