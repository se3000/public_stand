require 'feature_helper'

describe "Calling" do
  let(:user) { users(:gillian) }
  let(:organization) { user.organizations.first }
  let(:campaign) { organization.campaigns.first }

  before do
    log_in_as user
    visit organization_campaign_path(organization, campaign)
  end

  it "calls the user" do
    fill_in "Your Phone Number", with: '+15183346656'
    click_button "Connect Me"
  end
end
