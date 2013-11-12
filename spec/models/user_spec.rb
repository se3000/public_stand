require 'spec_helper'

describe User do
  describe "validations" do
    it { should have_valid(:first_name).when('Steve', 'S') }
    it { should_not have_valid(:first_name).when(nil, '') }

    it { should have_valid(:last_name).when('Ellis', 'E') }
    it { should_not have_valid(:last_name).when(nil, '') }
  end
end
