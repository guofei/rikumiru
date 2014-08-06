class Company < ActiveRecord::Base
  has_many :tweets

  scope :sorted_by_name, -> { first(500).order("name") }
end
