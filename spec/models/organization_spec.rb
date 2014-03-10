require 'spec_helper'

describe Organization do
  describe "validations" do
    it { should have_valid(:name).when('Clear Water Initiative') }
    it { should_not have_valid(:name).when(nil, '') }

    it { should have_valid(:vanity_string).when('foo') }
    it { should_not have_valid(:vanity_string).when(nil, '') }

    it "allows for long descriptions" do
      FactoryGirl.build(:organization, description: '*'*1000).save!
    end

    describe "#vanity_string" do
      let(:other_organization) { FactoryGirl.create(:organization) }

      it { should have_valid(:vanity_string).when((other_organization.vanity_string + '1'))}
      it { should_not have_valid(:vanity_string).when(other_organization.vanity_string, '', nil)}
    end
  end
end
