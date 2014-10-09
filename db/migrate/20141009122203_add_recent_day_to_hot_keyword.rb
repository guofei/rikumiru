class AddRecentDayToHotKeyword < ActiveRecord::Migration
  def change
    add_column :hot_keywords, :recent_day, :integer
  end
end
