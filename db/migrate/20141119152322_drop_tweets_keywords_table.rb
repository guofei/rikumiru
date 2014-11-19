class DropTweetsKeywordsTable < ActiveRecord::Migration
  def change
    drop_table :tweets_keywords
  end
end
