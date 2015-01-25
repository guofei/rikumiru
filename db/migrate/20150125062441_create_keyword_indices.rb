class CreateKeywordIndices < ActiveRecord::Migration
  def change
    create_table :keyword_indices do |t|
      t.string :name

      t.timestamps
    end
  end
end
