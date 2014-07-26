class CreateTweetsKeywords < ActiveRecord::Migration
  def change
    create_table :tweets_keywords, id: false do |t|
      t.column :tweet_id, :bigint
      t.belongs_to :keyword
    end
  end
end
