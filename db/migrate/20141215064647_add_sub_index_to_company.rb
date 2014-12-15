class AddSubIndexToCompany < ActiveRecord::Migration
  def change
    add_reference :companies, :sub_index, index: true
  end
end
