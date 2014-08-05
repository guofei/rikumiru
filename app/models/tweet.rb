class Tweet < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :keywords, join_table: :tweets_keywords
  default_scope { order("created_at desc") }
  before_destroy do
    keywords.clear
    decrement_tweet_count
  end

  before_create :increment_tweet_count_before_create
  before_update :increment_tweet_count_before_update

  def increment_tweet_count_before_create
    self.keywords.each do |k|
      if useful == true
        k.increment!(:tweet_count)
      end
    end
  end

  def increment_tweet_count_before_update
    self.keywords.each do |k|
      if useful_changed?
        if useful == true
          k.increment!(:tweet_count)
        elsif useful == false
          k.decrement!(:tweet_count)
        end
      end
    end
  end

  def decrement_tweet_count
    self.keywords.each do |k|
      if useful == true
        k.decrement!(:tweet_count)
      end
    end
  end
end
