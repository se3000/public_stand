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
        FactoryGirl.create(:phone_call, call_duration: 10, status: 'completed', campaign: campaign_target.campaign, target: campaign_target.target)
        FactoryGirl.create(:phone_call, call_duration: 0, status: 'completed', campaign: campaign_target.campaign, target: campaign_target.target)
      end

      its(:average_call_time) { should == '0:05' }
    end

    context "when there are no phone calls" do
      before { PhoneCall.where(campaign: campaign_target.campaign, target: campaign_target.target).destroy_all }

      its(:average_call_time) { should be_nil }
    end
  end

  describe '#suggested_tweet' do
    subject { cmpgn_trgt.suggested_tweet }
    let(:campaign) { Campaign.last }

    context "when twitter_share_text is present" do
      let(:cmpgn_trgt) { CampaignTarget.new(campaign: campaign, twitter_share_text: 'Yo!') }
      it { should == cmpgn_trgt.twitter_share_text }
    end

    context "when twitter_share_text is not present" do
      let(:cmpgn_trgt) { CampaignTarget.new(twitter_share_text: '', campaign: campaign) }
      it { should == cmpgn_trgt.campaign.name }
    end
  end
end
