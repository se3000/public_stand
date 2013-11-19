require 'spec_helper'

describe Campaign do
  describe "validations" do
    it { should have_valid(:organization).when(Organization.last) }
    it { should_not have_valid(:organization).when(nil) }

    it { should have_valid(:name).when('Anything') }
    it { should_not have_valid(:name).when(nil, '') }
  end
end
