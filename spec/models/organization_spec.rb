require 'spec_helper'

describe Organization do
  describe "validations" do
    it { should have_valid(:name).when('Clear Water Initiative') }
    it { should_not have_valid(:name).when(nil, '') }

    it "allows for long descriptions" do
      FactoryGirl.build(:organization, description: '*'*1000).save!
    end
  end
end
