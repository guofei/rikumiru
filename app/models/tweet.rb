class Tweet < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :keywords, join_table: :tweets_keywords
  default_scope { order("created_at desc") }
  before_destroy { keywords.clear }
end
