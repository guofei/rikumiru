class Company < ActiveRecord::Base
  acts_as_commentable
  has_many :tweets
  has_many :keywords, -> { uniq }, through: :tweets

  paginates_per 100

  scope :sorted_by_name, -> { where("id < 201").order("name") }
  scope :rank, -> { order("tweet_count desc") }

  def self.reset_tweet_count
    self.all.each do |c|
      count = c.tweets.where(useful: true).count
      c.update_attributes(:tweet_count => count)
    end
  end
end
