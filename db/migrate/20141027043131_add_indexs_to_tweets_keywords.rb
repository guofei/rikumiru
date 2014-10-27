class AddIndexsToTweetsKeywords < ActiveRecord::Migration
  def change
    add_index :tweets_keywords, :tweet_id
    add_index :tweets_keywords, :keyword_id
  end
end
