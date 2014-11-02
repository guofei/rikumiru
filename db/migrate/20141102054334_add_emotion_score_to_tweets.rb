class AddEmotionScoreToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :emotion_score, :float
  end
end
