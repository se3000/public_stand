require 'feature_helper'

describe "Calling" do
  let(:user) { users(:gillian) }
  let(:organization) { user.organizations.first }
  let(:campaign) { organization.campaigns.first }
  let(:target) { campaign.targets.first }

  before do
    log_in_as user
    visit organization_campaign_path(organization, campaign)
  end

  it "calls the user", twilio: true do
    fill_in "Your Phone Number", with: '+15183346656'
    click_button "Call #{target.name} from my phone"
    page.should have_content "Thanks! We'll call you shortly."
  end
end
