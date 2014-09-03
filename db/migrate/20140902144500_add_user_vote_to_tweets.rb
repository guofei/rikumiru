class AddUserVoteToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :user_vote, :integer
  end
end
