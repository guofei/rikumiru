class Keyword < ActiveRecord::Base
  include Redis::Objects
  sorted_set :company_tweet_count

  has_and_belongs_to_many :tweets, join_table: :tweets_keywords
  has_many :companies, -> { uniq }, through: :tweets

  paginates_per 100

  before_destroy { tweets.clear }
  scope :rank, -> { order("tweet_count desc") }

  def self.reset_tweet_count
    self.all.each do |k|
      count = k.tweets.where(useful: true).count
      k.update_attributes(:tweet_count => count)
    end
  end

  def tweets_with_company(company)
    Rails.cache.fetch("#{cache_key}/#{company.id}/tweets_count_with_company", expires_in: 12.hours) do
      tweets.where(useful: true).where(company: company)
    end
  end

  def tweets_count_with_company(company)
    if company_tweet_count[company.id] > 0
      company_tweet_count[company.id].to_i
    else
      return 0 if company.tweet_count == 0
      count = tweets.where(useful: true).where(company: company).count
      company_tweet_count[company.id] = count
      count
    end
  end
end
