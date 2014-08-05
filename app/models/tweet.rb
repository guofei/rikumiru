class Tweet < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :keywords, join_table: :tweets_keywords
  default_scope { order("created_at desc") }
  before_destroy do
    keywords.clear
    decrement_tweet_count
  end

  before_save :increment_tweet_count

  def increment_tweet_count
    self.keywords.each do |k|
      k.increment!(:tweet_count)
    end
  end

  def decrement_tweet_count
    self.keywords.each do |k|
      k.decrement!(:tweet_count)
    end
  end
end
