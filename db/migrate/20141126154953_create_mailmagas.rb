class CreateMailmagas < ActiveRecord::Migration
  def change
    create_table :mailmagas do |t|
      t.string :email

      t.timestamps
    end
  end
end
