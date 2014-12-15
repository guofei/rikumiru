class SubIndex < ActiveRecord::Base
  belongs_to :main_index
  has_many :companies
end
