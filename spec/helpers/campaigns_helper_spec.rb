require 'spec_helper'

describe CampaignsHelper do
  describe "#tweet_button" do
    subject { helper.tweet_button(campaign_target) }
    context "when the target has default text" do
      let(:campaign_target) { FactoryGirl.create(:campaign_target, twitter_share_text: 'Check it out') }
      it { should include "text=#{helper.cgi_escape('Check it out')}" }
    end

    context "when the target does not have default text" do
      let(:campaign_target) { FactoryGirl.create(:campaign_target, twitter_share_text: nil) }
      it { should include "text=#{helper.cgi_escape(campaign_target.campaign.name)}" }
    end
  end
end
