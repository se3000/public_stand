require 'spec_helper'

describe PhoneCallFeedback do
  describe "validations" do
    it { should have_valid(:phone_call).when(FactoryGirl.create(:phone_call)) }
    it { should_not have_valid(:phone_call).when(nil) }
  end
end
