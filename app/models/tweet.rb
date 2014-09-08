class Tweet < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :keywords, join_table: :tweets_keywords
  default_scope { order("created_at desc") }

  before_destroy do
    change_tweet_count_before_destroy
    keywords.clear
  end
  before_create :change_tweet_count_before_create
  before_update :change_tweet_count_before_update

  paginates_per 100

  def self.period_count_array(from = 31.days.ago.beginning_of_day, to = Date.yesterday.end_of_day)
    where(created_at: from..to).unscoped.group('date(created_at)').count
  end

  def change_tweet_count_before_create
    keywords.each do |k|
      if useful == true
        k.increment!(:tweet_count)
        k.company_tweet_count.increment [company.id] if k.company_tweet_count[company.id] > 0
      end
    end
    if useful == true
      company.increment!(:tweet_count)
    end
  end

  def change_tweet_count_before_update
    keywords.each do |k|
      if useful_changed?
        if useful == true
          k.increment!(:tweet_count)
          k.company_tweet_count.increment [company.id] if k.company_tweet_count[company.id] > 0
        elsif useful != true && useful_was == true
          k.decrement!(:tweet_count)
          k.company_tweet_count.decrement [company.id] if k.company_tweet_count[company.id] > 0
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

  def change_tweet_count_before_destroy
    keywords.each do |k|
      if useful == true
        k.decrement!(:tweet_count)
        k.company_tweet_count.decrement [company.id] if k.company_tweet_count[company.id] > 0
      end
    end
    if useful == true
      company.decrement!(:tweet_count)
    end
  end
end
