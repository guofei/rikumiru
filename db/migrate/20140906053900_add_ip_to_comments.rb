class AddIpToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ip, :string
  end
end
