class AddCompanyAndKeywordToMailmaga < ActiveRecord::Migration
  def change
    add_reference :mailmagas, :company, index: true
    add_reference :mailmagas, :keyword, index: true
  end
end
