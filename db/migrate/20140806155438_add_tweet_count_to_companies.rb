class AddTweetCountToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :tweet_count, :integer
  end
end
