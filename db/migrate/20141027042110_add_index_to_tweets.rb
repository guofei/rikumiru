class AddIndexToTweets < ActiveRecord::Migration
  def change
    add_index :tweets, :company_id
  end
end
