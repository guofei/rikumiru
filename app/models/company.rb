class Company < ActiveRecord::Base
  acts_as_commentable
  has_many :tweets
  has_many :hot_keywords
  has_many :keywords, -> { uniq }, through: :tweets
  belongs_to :sub_index
  delegate :main_index, to: :sub_index

  paginates_per 100

  scope :sorted_by_name, -> { where("id < 201").order("name") }
  scope :rank, -> { order("tweet_count desc") }

  def self.reset_tweet_count
    self.all.each do |c|
      count = c.tweets.where(useful: true).count
      c.update_attributes(:tweet_count => count)
    end
  end

  def keywords_rank(n = 40)
    # slow!
    keywords.reorder("tweet_count desc").take(200).inject({}) do |hash, k|
      count = k.tweets_count_with_company self
      if count > 0
        hash.merge(k => count)
      else
        hash
      end
    end.sort{ |(k1, v1), (k2, v2)| v2 <=> v1 }.take(n)
  end
end
