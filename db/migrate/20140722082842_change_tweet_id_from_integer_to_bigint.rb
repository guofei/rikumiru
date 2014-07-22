class ChangeTweetIdFromIntegerToBigint < ActiveRecord::Migration
  def change
    change_column :tweets, :id, :bigint
  end
end
