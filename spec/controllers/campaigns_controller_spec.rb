require 'spec_helper'

describe CampaignsController do
  let(:user) { users(:gillian) }
  let(:organization) { user.organizations.first }

  before { log_in user }

  describe "#new" do
    it "builds a new campaign" do
      get :new, organization_id: organization.id
      campaign = assigns(:campaign)

      expect(response).to be_success
      expect(campaign).to be_a Campaign
      expect(campaign).to be_new_record
      expect(assigns(:organization)).to eq organization
      expect(assigns(:campaign_target)).to be_a CampaignTarget
      expect(assigns(:target)).to be_a Target
    end
  end

  describe "#create" do
    context "when the campaign is valid" do
      let(:campaign_params) { { name: 'May all you pain be campaign' } }

      it "creates a new instance of campaign" do
        expect {
          post :create, organization_id: organization.id, campaign: campaign_params
        }.to change { Campaign.count }.by(+1)

        expect(response).to redirect_to [organization, Campaign.last]
      end
    end

    context "when the campaign is invalid" do
      let(:campaign_params) { { name: nil } }

      it "does not create a new campaign" do
        expect {
          post :create, organization_id: organization.id, campaign: campaign_params
        }.not_to change { Campaign.count }

        expect(response).to render_template :new
        expect(assigns(:campaign_target)).to be_a CampaignTarget
        expect(assigns(:target)).to be_a Target
      end
    end
  end

  describe "#show" do
    let(:campaign) { organization.campaigns.first }

    it "builds a new campaign" do
      get :show, organization_id: organization.id, id: campaign.id

      expect(response).to be_success
      expect(assigns(:organization)).to eq organization
      expect(assigns(:campaign)).to eq campaign
    end
  end
end

describe "CampaignsController::Params" do
  describe ".clean" do
    subject { CampaignsController::Params.clean(params) }

    let(:params) do
      ActionController::Parameters.new(
        organization_id: 1,
        campaign: {
          name: 'No Campaign, No Gain.',
          description: 'Hilarity ensues as Sebastian(Dwayne Johnson) tries to convince politicians, and the world, that Independents are people too.',
          release_date: 'November 11th, 2014',
          campaign_targets_attributes: [{
            script: 'hey',
            target_attributes: [{name: 'a', phone_number: '1', other: 'b'}]
          }]
        }
      )
    end

    it { should eq({
        name: 'No Campaign, No Gain.',
        description: 'Hilarity ensues as Sebastian(Dwayne Johnson) tries to convince politicians, and the world, that Independents are people too.',
        campaign_targets_attributes: [{
          script: 'hey', target_attributes: [{name: 'a', phone_number: '1'}]
        }]
      }.with_indifferent_access)
    }
  end
end
