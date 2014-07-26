class AddCategoryToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :category, :integer
  end
end
