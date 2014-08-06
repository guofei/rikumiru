class Company < ActiveRecord::Base
  has_many :tweets

  scope :sorted_by_name, -> { where("id < 201").order("name") }
end
