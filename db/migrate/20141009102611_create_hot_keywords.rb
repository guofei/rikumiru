class CreateHotKeywords < ActiveRecord::Migration
  def change
    create_table :hot_keywords do |t|
      t.references :company, index: true
      t.string :name
      t.boolean :useful, default: true

      t.timestamps
    end
  end
end
