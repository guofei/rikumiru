class RemoveCategoryFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :category, :integer
  end
end
