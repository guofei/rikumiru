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

  def keywords_rank
    hash = {}
    keywords.reorder("tweet_count desc").take(200).each do |k|
      hash[k] = k.tweets_count_with_company self
    end
    hash.sort{ |(k1, v1), (k2, v2)| v2 <=> v1 }.take(40).to_h.delete_if {|key, val| val <= 0 }
  end
end
