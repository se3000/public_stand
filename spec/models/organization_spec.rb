require 'spec_helper'

describe Organization do
  describe "validations" do
    it { should have_valid(:name).when('Clear Water Initiative') }
    it { should_not have_valid(:name).when(nil, '') }
  end
end
