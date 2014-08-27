class Keyword < ActiveRecord::Base
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
    Rails.cache.fetch("#{cache_key}/#{company.id}/tweets_count_with_company", expires_in: 12.hours) do
      tweets.where(useful: true).where(company: company).count
    end
  end
end
