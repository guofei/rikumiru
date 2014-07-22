class ChangeCompanyTweetIdFromIntegerToBigint < ActiveRecord::Migration
  def change
    change_column :companies, :tweet_id, :bigint
  end
end
