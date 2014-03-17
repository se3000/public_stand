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

  describe ".lookup" do
    subject{ Organization.lookup(host_url, vanity_string, organization_id) }

    let!(:organization_by_host_url) { FactoryGirl.create(:organization, host_url: 'wooo!') }
    let!(:organization_by_vanity_string) { FactoryGirl.create(:organization) }
    let!(:organization_by_id) { FactoryGirl.create(:organization) }
    let(:host_url) { organization_by_host_url.host_url }
    let(:vanity_string) { organization_by_vanity_string.vanity_string }
    let(:organization_id) { organization_by_id.id }

    context "when the host_url is present" do
      it { should == organization_by_host_url }
    end

    context "when the vanity string is present but no host_url" do
      let(:host_url) { nil }
      it { should == organization_by_vanity_string }

      context "and the subdomain has a base" do
        let(:subdomain_base) { 'subdomain-base' }
        let(:vanity_string) { "#{organization_by_vanity_string.vanity_string}.#{subdomain_base}" }
        before { Rails.configuration.stub(subdomain_base: subdomain_base) }

        it { should == organization_by_vanity_string }
      end
    end

    context "when just the id is present" do
      let(:host_url) { nil }
      let(:vanity_string) { nil }
      it { should == organization_by_id }
    end
  end

  describe "#campaign_lookup" do
    subject { organization.campaign_lookup(vanity_string, campaign_id) }

    let(:organization) { Organization.first }
    let(:campaign_by_vanity) { FactoryGirl.create(:campaign, organization: organization) }
    let(:campaign_by_id) { FactoryGirl.create(:campaign, organization: organization) }
    let(:vanity_string) { campaign_by_vanity.vanity_string }
    let(:campaign_id) { campaign_by_id.id }

    context "when the vanity string is present" do
      it { should == campaign_by_vanity }
    end

    context "when only the id is present" do
      let(:vanity_string) { nil }
      it { should == campaign_by_id }
    end

    context "when only the id is present" do
      let(:vanity_string) { nil }
      let(:campaign_id) { nil }
      it { should be_nil }
    end
  end
end
