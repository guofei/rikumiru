class AddCategoryToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :category, :integer
  end
end
