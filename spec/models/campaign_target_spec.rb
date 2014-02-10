require 'spec_helper'

describe CampaignTarget do
  describe "validations" do
    it { should have_valid(:campaign).when(Campaign.all.sample) }
    it { should_not have_valid(:campaign).when(nil) }

    it { should have_valid(:target).when(Target.all.sample) }
    it { should_not have_valid(:target).when(nil) }
  end

  describe "#phone_calls" do
    subject { campaign_target.phone_calls }

    let(:campaign_target) { campaign_targets(:claire_campaign_target) }
    let(:match) { FactoryGirl.create(:phone_call, campaign: campaign_target.campaign, target: campaign_target.target) }
    let(:campaign_match) { FactoryGirl.create(:phone_call, campaign: campaign_target.campaign) }
    let(:target_match) { FactoryGirl.create(:phone_call, campaign: campaign_target.campaign) }

    it { should include match }
    it { should_not include campaign_match }
    it { should_not include target_match }
  end

  describe "#average_call_time" do
    subject(:campaign_target) { FactoryGirl.create(:campaign_target) }

    context "when there are phone calls" do
      before do
        FactoryGirl.create(:phone_call, call_duration: 120, status: 'completed', campaign: campaign_target.campaign, target: campaign_target.target)
        FactoryGirl.create(:phone_call, call_duration: 90, status: 'completed', campaign: campaign_target.campaign, target: campaign_target.target)
      end

      its(:average_call_time) { should == '1:45' }
    end

    context "when there are no phone calls" do
      before { PhoneCall.where(campaign: campaign_target.campaign, target: campaign_target.target).destroy_all }

      its(:average_call_time) { should be_nil }
    end
  end
end
