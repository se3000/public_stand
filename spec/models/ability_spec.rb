require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject { Ability.new(user) }

  context "when the user is signed in" do
    let(:user) { FactoryGirl.create(:user) }
    let(:organization) { FactoryGirl.create(:organization) }
    let(:campaign) { FactoryGirl.create(:campaign, organization: organization) }

    context "when a user is a part of an organization" do
      before { FactoryGirl.create(:membership, member: user, organization: organization) }

      it { should be_able_to(:manage, campaign) }
      it { should be_able_to(:manage, organization) }
    end

    context "when a user is a part of a different organization" do
      it { should be_able_to(:read, campaign) }
      it { should be_able_to(:read, organization) }
      it { should be_able_to(:create, campaign) }
      it { should be_able_to(:create, organization) }

      it { should_not be_able_to(:manage, campaign) }
      it { should_not be_able_to(:manage, organization) }
    end
  end

  context "when the user is not signed in" do
    let(:user) { nil }

    it { should be_able_to(:read, Campaign) }
    it { should be_able_to(:read, Organization) }

    it { should_not be_able_to(:manage, Campaign) }
    it { should_not be_able_to(:manage, Organization) }
  end
end
