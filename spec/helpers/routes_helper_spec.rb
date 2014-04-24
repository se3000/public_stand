require 'spec_helper'

describe RoutesHelper do
  describe '#organization_vanity' do
    let(:organization) { Organization.new(vanity_string: 'test', host_url: host_url) }
    subject { helper.organization_vanity(organization) }

    context "when the organizaiton does not have a host url" do
      let(:host_url) { nil }

      context "when the user is not logged in" do
        before { helper.stub(logged_in?: true) }
        it { should == "http://test.lvh.me:#{ENV['PORT']}/" }
      end

      context "when the user is not logged in" do
        before { helper.stub(logged_in?: false) }
        it { should == "http://test.lvh.me:#{ENV['PORT']}/" }
      end
    end

    context "when the organization has a host url" do
      let(:host_url) { 'boom.example.com' }

      context "when the user is not logged in" do
        before { helper.stub(logged_in?: true) }
        it { should == "http://test.lvh.me:#{ENV['PORT']}/" }
      end

      context "when the user is not logged in" do
        before { helper.stub(logged_in?: false) }
        it { should == "http://boom.example.com:#{ENV['PORT']}/" }
      end
    end
  end

  describe '#campaign_vanity' do
    let(:organization) { Organization.new(vanity_string: 'test', host_url: host_url) }
    let(:campaign) { Campaign.new(organization: organization, vanity_string: 'the-best') }
    subject { helper.campaign_vanity(campaign) }

    context "when the organizaiton does not have a host url" do
      let(:host_url) { nil }

      context "when the user is logged in" do
        before { helper.stub(logged_in?: true) }
        it { should == "http://test.lvh.me:#{ENV['PORT']}/the-best" }
      end

      context "when the user is not logged in" do
        before { helper.stub(logged_in?: false) }
        it { should == "http://test.lvh.me:#{ENV['PORT']}/the-best" }
      end
    end

    context "when the organization has a host url" do
      let(:host_url) { 'boom.example.com' }

      context "when the user is not logged in" do
        before { helper.stub(logged_in?: true) }
        it { should == "http://test.lvh.me:#{ENV['PORT']}/the-best" }
      end

      context "when the user is not logged in" do
        before { helper.stub(logged_in?: false) }
        it { should == "http://boom.example.com:#{ENV['PORT']}/the-best" }
      end
    end
  end
end
