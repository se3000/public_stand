module ApplicationHelper
  def cgi_escape(url)
    CGI.escape(url).html_safe
  end
end
