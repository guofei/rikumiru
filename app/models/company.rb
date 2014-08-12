class Company < ActiveRecord::Base
  has_many :tweets

  scope :sorted_by_name, -> { where("id < 201").order("name") }
  scope :rank, -> { order("tweet_count desc") }

  def self.reset_tweet_count
    self.all.each do |c|
      count = c.tweets.where(useful: true).count
      c.update_attributes(:tweet_count => count)
    end
  end
end
