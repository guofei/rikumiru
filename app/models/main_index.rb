class MainIndex < ActiveRecord::Base
  has_many :sub_indices
  has_many :companies, through: :sub_indices
end
