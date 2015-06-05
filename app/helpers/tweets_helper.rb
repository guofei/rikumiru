module TweetsHelper
  def img_url(tweet)
    tweet.profile_img.nil? ? "http://abs.twimg.com/sticky/default_profile_images/default_profile_2_normal.png" : tweet.profile_img
  end
end
