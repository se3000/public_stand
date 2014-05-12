module CampaignsHelper
  def average_call_time_of(cmpgn_trgt)
    cmpgn_trgt.average_call_time || "0:00"
  end

  def in_browser_call_button(campaign_target, options = {})
    link_to("Call from your computer", '#', {
      class: 'button postfix',
      data: {
        behavior: 'callTrigger',
        call_type: 'browser',
        campaign_target_id: campaign_target.id,
        auto_trigger: options[:auto_trigger]
      }
    })
  end

  def mobile_call_button(campaign_target, options = {})
    text = options[:text] || "Call from your phone"
    link_to(text, '#', {
      class: 'button postfix mobile-call',
      data: {
        behavior: 'callTrigger',
        call_type: 'mobile',
        campaign_id: campaign_target.campaign_id,
        auto_trigger: options[:auto_trigger]
      }
    })
  end

  def facebook_share_button(cmpgn_trgt)
    facebook_url = "https://www.facebook.com/sharer/sharer.php?u=#{cgi_escape(campaign_target_share_url(cmpgn_trgt))}"
    link_to image_tag('facebook_share.png', style: 'width: 110px; height: 30px;'), facebook_url, target: '_blank'
  end

  def tweet_button(cmpgn_trgt)
    description = cmpgn_trgt.twitter_share_text || cmpgn_trgt.campaign.name
    twitter_url = "https://twitter.com/intent/tweet?related=publicstand&source=tweetbutton&text=#{cgi_escape(description)}&url=#{cgi_escape(campaign_target_share_url(cmpgn_trgt))}"
    link_to image_tag('twitter_share.png', style: 'width: 110px; height: 30px;'), twitter_url, target: '_blank'
  end

  def campaign_target_share_url(cmpgn_trgt)
    campaign = cmpgn_trgt.campaign
    campaign_vanity(campaign)
  end
end
