require 'spec_helper'

describe Campaign do
  describe "validations" do
    it { should have_valid(:organization).when(Organization.last) }
    it { should_not have_valid(:organization).when(nil) }

    it { should have_valid(:name).when('Anything') }
    it { should_not have_valid(:name).when(nil, '') }
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
