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

  paginates_per 100

  def increment_tweet_count_before_create
    keywords.each do |k|
      if useful == true
        k.increment!(:tweet_count)
      end
    end
    if useful == true
      company.increment!(:tweet_count)
    end
  end

  def increment_tweet_count_before_update
    keywords.each do |k|
      if useful_changed?
        if useful == true
          k.increment!(:tweet_count)
        elsif useful != true && useful_was == true
          k.decrement!(:tweet_count)
        end
      end
    end
    if useful_changed?
      if useful == true
        company.increment!(:tweet_count)
      elsif useful != true && useful_was == true
        company.decrement!(:tweet_count)
      end
    end
  end

  def decrement_tweet_count
    keywords.each do |k|
      if useful == true
        k.decrement!(:tweet_count)
      end
    end
    if useful == true
      company.decrement!(:tweet_count)
    end
  end
end
