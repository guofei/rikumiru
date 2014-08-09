class RenameCategoryToTweet < ActiveRecord::Migration
  def change
    rename_column :tweets, :category, :category_id
  end
end
