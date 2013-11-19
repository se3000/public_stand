require 'spec_helper'

describe Membership do
  describe "validations" do
    it { should have_valid(:member).when(User.first) }
    it { should_not have_valid(:member).when(nil) }

    it { should have_valid(:organization).when(Organization.first) }
    it { should_not have_valid(:organization).when(nil) }
  end
end
