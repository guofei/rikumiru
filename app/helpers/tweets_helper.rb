module TweetsHelper
  def img_url(tweet)
    tweet.profile_img.nil? ? "http://abs.twimg.com/sticky/default_profile_images/default_profile_2_normal.png" : tweet.profile_img
  end

  def need_vote(tweets)
    tweet = tweets.where(user_vote: nil).first
    if tweet.nil?
      tweets.where('user_vote > -3').where('user_vote < 3').first
    else
      tweet
    end
  end
end
