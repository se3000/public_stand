module ApplicationHelper
  def facebook_share_button(url)
    link_to image_tag('facebook_share.png', style: 'width: 110px; height: 30px;'), "https://www.facebook.com/sharer/sharer.php?u=#{cgi_escape(url)}", target: '_blank'
  end

  def tweet_button(url, description)
    link_to image_tag('twitter_share.png', style: 'width: 110px; height: 30px;'), "https://twitter.com/intent/tweet?related=publicstand&source=tweetbutton&text=#{description}: #{cgi_escape(url)}", target: '_blank'
  end

  def cgi_escape(url)
    CGI.escape(url).html_safe
  end
end
