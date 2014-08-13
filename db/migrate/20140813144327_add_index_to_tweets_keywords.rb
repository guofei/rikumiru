class AddIndexToTweetsKeywords < ActiveRecord::Migration
  def change
    add_index :tweets_keywords, [:tweet_id, :keyword_id], unique: true
    add_index :tweets_keywords, [:keyword_id, :tweet_id], unique: true
  end
end
