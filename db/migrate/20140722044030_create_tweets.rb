class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :company_id
      t.string :text
      t.string :username
      t.boolean :useful

      t.timestamps
    end
  end
end
