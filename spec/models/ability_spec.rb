require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject { Ability.new(user) }

  context "when the user is signed in" do
    let(:user) { User.last }

    it { should be_able_to(:manage, Campaign) }
    it { should be_able_to(:manage, Organization) }
  end

  context "when the user is not signed in" do
    let(:user) { nil }

    it { should be_able_to(:read, Campaign) }
    it { should_not be_able_to(:manage, Campaign) }

    it { should be_able_to(:read, Organization) }
    it { should_not be_able_to(:manage, Organization) }
  end
end
