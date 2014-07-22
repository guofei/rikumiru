class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :alice_name
      t.integer :tweet_id

      t.timestamps
    end
  end
end
