require 'spec_helper'

describe TwilioCallbacksController do
  describe "#outbound_voice" do
    it "returns TwiML" do
      get :outbound_voice

      expect(response).to be_success
    end
  end
end
