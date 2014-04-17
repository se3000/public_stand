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

  describe "#edit" do
    let(:campaign) { organization.campaigns.first }

    it "retreives the campaign and organization" do
      get :edit, organization_id: organization.id, id: campaign.id

      expect(assigns(:organization)).to eq organization
      expect(assigns(:campaign)).to eq campaign
    end
  end

  describe "#create" do
    context "when the campaign is valid" do
      let(:campaign_params) { FactoryGirl.attributes_for(:campaign) }

      it "creates a new instance of campaign" do
        expect {
          post :create, organization_id: organization.id, campaign: campaign_params
        }.to change { Campaign.count }.by(+1)

        expect(response).to redirect_to "http://#{organization.vanity_string}.test.host/#{Campaign.last.vanity_string}"
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

  describe "#update" do
    let(:campaign) { organization.campaigns.first }

    context "when the campaign is valid" do
      let(:campaign_params) { {name: 'May all your pain be campaign'} }

      it "creates a new instance of campaign" do
        expect {
          patch :update, organization_id: organization.id, id: campaign.id, campaign: campaign_params
        }.to change { campaign.reload.name }.to('May all your pain be campaign')

        expect(response).to redirect_to "http://#{organization.vanity_string}.test.host/#{campaign.vanity_string}"
      end
    end

    context "when the campaign is invalid" do
      let(:campaign_params) { { name: nil } }

      it "does not create a new campaign" do
        expect {
          patch :update, organization_id: organization.id, id: campaign.id, campaign: campaign_params
        }.not_to change { Campaign.count }

        expect(response).to render_template :edit
        expect(assigns(:campaign_target)).to be_a CampaignTarget
        expect(assigns(:target)).to be_a Target
      end
    end
  end

  describe "#show" do
    let(:campaign) { organization.campaigns.first }

    it "displays the campaign" do
      get :show, organization_id: organization.id, id: campaign.id

      expect(response).to be_success
      expect(assigns(:organization)).to eq organization
      expect(assigns(:campaign)).to eq campaign
    end

    it "builds a new call token" do
      TwilioClient.better_receive(:outgoing_token).and_return('twilioToken123')

      get :show, organization_id: organization.id, id: campaign.id

      expect(assigns(:twilio_token)).to eq('twilioToken123')
    end

    context "when the current user is not an organizer" do
      before { log_in FactoryGirl.create(:authentication) }

      it "builds a picture uploader" do
        get :show, organization_id: organization.id, id: campaign.id

        expect(assigns(:picture_uploader)).to be_nil
      end
    end

    context "when the auto param is set" do
      it "builds a picture uploader" do
        get :show, auto: true, organization_id: organization.id, id: campaign.id

        expect(assigns(:auto_trigger)).to be_true
      end
    end

    context "when the auto param is false" do
      it "builds a picture uploader" do
        get :show, auto: false, organization_id: organization.id, id: campaign.id

        expect(assigns(:auto_trigger)).to be_false
      end
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
          vanity_string: 'so-vain',
          campaign_targets_attributes: [{
            id: 1,
            campaign_id: 2,
            target_id: 3,
            script: 'hey',
            twitter_share_text: 'Hello Internet!',
            target_attributes: [{name: 'a', phone_number: '1', other: 'b'}]
          }]
        }
      )
    end

    it { should eq({
        name: 'No Campaign, No Gain.',
        description: 'Hilarity ensues as Sebastian(Dwayne Johnson) tries to convince politicians, and the world, that Independents are people too.',
        vanity_string: 'so-vain',
        campaign_targets_attributes: [{
          id: 1,
          campaign_id: 2,
          target_id: 3,
          script: 'hey',
          twitter_share_text: 'Hello Internet!',
          target_attributes: [{name: 'a', phone_number: '1'}]
        }]
      }.with_indifferent_access)
    }
  end
end
