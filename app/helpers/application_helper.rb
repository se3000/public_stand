module ApplicationHelper
  def facebook_share_button(url)
    <<-HTML.html_safe
    <script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=591276310956138";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>

    <div class="fb-share-button" data-href="#{url}" data-width="1000" data-type="button"></div>
    HTML
  end

  def tweet_button(url, description)
    <<-HTML.html_safe
      <a href="https://twitter.com/share" class="twitter-share-button" data-url="#{url}" data-text="#{description}" data-count="none">Tweet</a>
      <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
    HTML
  end
end
