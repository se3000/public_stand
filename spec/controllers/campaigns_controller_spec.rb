require 'spec_helper'

describe CampaignsController do
  describe "#new" do
    let(:user) { users(:gillian) }
    let(:organization) { user.organizations.first }

    before { log_in user }

    it "builds a new campaign" do
      get :new, organization_id: organization.id
      campaign = assigns(:campaign)

      expect(response).to be_success
      expect(campaign).to be_new_record
      expect(campaign).to be_a Campaign
    end
  end
end
