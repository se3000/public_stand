module CampaignsHelper
  def average_call_time_of(cmpgn_trgt)
    cmpgn_trgt.average_call_time || "0:00 (No calls completed yet)"
  end

  def in_browser_call_button(campaign_target, options = {})
    link_to("Call from your computer", '#', {
      class: 'button postfix',
      data: {
        behavior: 'callTrigger',
        campaign_id: campaign_target.campaign_id,
        auto_trigger: options[:auto_trigger]
      }
    })
  end

  def hang_up_button
    link_to("Hang Up", '#', class: 'hang-up-btn btn disabled',
      data: {behavior: 'displayNextStep hangUpTrigger'})
  end
end
