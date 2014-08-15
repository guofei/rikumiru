class AddBayesfilterToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :bayesfilter, :boolean
  end
end
