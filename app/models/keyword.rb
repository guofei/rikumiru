class Keyword < ActiveRecord::Base
  has_and_belongs_to_many :tweets, join_table: :tweets_keywords
  has_many :companies, -> { uniq }, through: :tweets
  before_destroy { tweets.clear }
  scope :rank, -> { order("tweet_count desc") }

  def self.reset_tweet_count
    self.all.each do |k|
      count = k.tweets.where(useful: true).count
      k.update_attributes(:tweet_count => count)
    end
  end
end
