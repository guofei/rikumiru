class Keyword < ActiveRecord::Base
  include Redis::Objects
  sorted_set :company_tweet_count

  belongs_to :keyword_index
  has_many :tweets
  has_many :companies, -> { uniq }, through: :tweets

  paginates_per 30

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
    if company_tweet_count.member? company.id
      company_tweet_count[company.id].to_i
    else
      count = tweets.where(useful: true).where(company: company).select("id").count
      company_tweet_count[company.id] = count
      count
    end
  end

  def hot_companies()
    Rails.cache.fetch("kw/#{id}/htcp") do
      hash = {}
      companies.reorder("tweet_count desc").take(200).each do |com|
        hash[com] = tweets_count_with_company com
      end
      hash.sort{ |(k1, v1), (k2, v2)| v2 <=> v1 }.take(40).to_h.delete_if {|key, val| val <= 0 }
    end
  end
end
