require 'spec_helper'

describe CampaignTarget do
  describe "validations" do
    it { should have_valid(:campaign).when(Campaign.all.sample) }
    it { should_not have_valid(:campaign).when(nil) }

    it { should have_valid(:target).when(Target.all.sample) }
    it { should_not have_valid(:target).when(nil) }
  end

  describe "#average_call_time" do
    subject(:campaign_target) { FactoryGirl.create(:campaign_target) }

    context "when there are phone calls" do
      before do
        FactoryGirl.create(:phone_call, call_duration: 10, status: 'completed', campaign_target: campaign_target)
        FactoryGirl.create(:phone_call, call_duration: 0, status: 'completed', campaign_target: campaign_target)
      end

      it "averages out the call duration" do
        campaign_target.average_call_time.should == '0:05'
      end
    end

    context "when there are no phone calls" do
      before { PhoneCall.where(campaign_target_id: campaign_target.id).destroy_all }

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
