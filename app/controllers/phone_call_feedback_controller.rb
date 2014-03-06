class PhoneCallFeedbackController < ApplicationController
  def create
    feedback = PhoneCallFeedback.create(Params.clean(params))
    render json: { phone_call_feedback_id: feedback.id }
  end

  class Params
    def self.clean(params)
      params.permit(:phone_call_id, :email_address, :comments)
    end
  end
end
