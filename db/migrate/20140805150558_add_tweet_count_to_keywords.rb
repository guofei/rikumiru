class AddTweetCountToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :tweet_count, :integer
  end
end
