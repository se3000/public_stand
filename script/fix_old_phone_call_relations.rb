PhoneCall.where('campaign_target_id IS NULL').pluck(:id).each do |phone_call_id|
  phone_call = PhoneCall.find(phone_call_id)
  campaign_target = CampaignTarget.find_by_campaign_id_and_target_id(phone_call.campaign_id, phone_call.target_id)
  next if campaign_target.nil?

  phone_call.campaign_target = campaign_target

  phone_call.save!
end
