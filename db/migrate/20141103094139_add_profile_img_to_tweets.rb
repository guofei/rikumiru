class AddProfileImgToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :profile_img, :string
  end
end
