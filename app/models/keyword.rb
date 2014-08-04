class Keyword < ActiveRecord::Base
  has_and_belongs_to_many :tweets, join_table: :tweets_keywords
  before_destroy { tweets.clear }
end
