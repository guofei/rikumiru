class AddKeywordIndexToKeyword < ActiveRecord::Migration
  def change
    add_reference :keywords, :keyword_index, index: true
  end
end
