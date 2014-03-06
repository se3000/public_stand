require 'spec_helper'

describe PhoneCallFeedbackController do
  describe "#create" do
    let(:phone_call) { FactoryGirl.create(:phone_call) }
    let(:feedback_params) { {phone_call_id: phone_call.id, phone_call_feedback: {email_address: nil, phone_call_id: phone_call.id}} }

    it "creates a new feedback record" do
      expect {
        post :create, feedback_params
      }.to change { PhoneCallFeedback.count }.by(+1)
    end
  end
end

describe "PhoneCallFeedbacksController::Params" do
  describe ".clean" do
    let(:params) do
      ActionController::Parameters.new(
        'junk' => 'blah',
        "email_address" => 'ex@mple.com',
        "comments" => 'boo! yeah!',
        "phone_call_id" => 272
      )
    end

    it "sets the target and the campaign" do
      cleaned = PhoneCallFeedbackController::Params.clean(params)

      expect(cleaned).to eq({
        "phone_call_id"    => 272,
        "email_address" => 'ex@mple.com',
        "comments" => 'boo! yeah!'
      })
    end
  end
end
