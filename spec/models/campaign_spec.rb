require 'spec_helper'

describe Campaign do
  describe "validations" do
    it { should have_valid(:organization).when(Organization.last) }
    it { should_not have_valid(:organization).when(nil) }

    it { should have_valid(:name).when('Anything') }
    it { should_not have_valid(:name).when(nil, '') }

    it { should have_valid(:vanity_string).when('bar') }
    it { should_not have_valid(:vanity_string).when(nil, '') }

    describe "#vanity_string" do
      subject { FactoryGirl.create(:campaign) }
      let(:same_organizations_campaign) { FactoryGirl.create(:campaign, organization: subject.organization) }
      let(:other_organizations_campaign) { FactoryGirl.create(:campaign) }

      it { should have_valid(:vanity_string).when(other_organizations_campaign.vanity_string)}
      it { should_not have_valid(:vanity_string).when(same_organizations_campaign.vanity_string, nil)}
    end
  end

  describe "on creation" do
    it "creates a picture" do
      campaign = FactoryGirl.build(:campaign)

      expect(campaign.picture).to be_nil
      campaign.save
      expect(campaign.picture).to be_present
    end
  end
end
