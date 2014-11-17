class AddKeywordToTweet < ActiveRecord::Migration
  def change
    add_reference :tweets, :keyword, index: true
  end
end
