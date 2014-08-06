class Company < ActiveRecord::Base
  has_many :tweets

  scope :sorted_by_name, -> { where("id < 201").order("name") }
  scope :sorted_by_tweet, -> { joins(:tweets).group("tweets.company_id").order("count(tweets.company_id) desc") }
end
