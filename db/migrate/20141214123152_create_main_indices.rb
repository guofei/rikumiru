class CreateMainIndices < ActiveRecord::Migration
  def change
    create_table :main_indices do |t|
      t.string :name

      t.timestamps
    end
  end
end
