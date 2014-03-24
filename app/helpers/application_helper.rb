module ApplicationHelper
  def cgi_escape(url)
    CGI.escape(url).html_safe
  end

  def mixpanel_enabled?
    ENV['MIXPANEL_TOKEN'].present?
  end

  def ga_enabled?
    Rails.env.production?
  end
end
