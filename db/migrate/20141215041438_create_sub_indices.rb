class CreateSubIndices < ActiveRecord::Migration
  def change
    create_table :sub_indices do |t|
      t.string :name
      t.references :main_index, index: true

      t.timestamps
    end
  end
end
