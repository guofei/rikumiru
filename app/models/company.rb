class Company < ActiveRecord::Base
  has_many :tweets

  scope :sorted_by_name, -> { where("id < 501").order("name") }
end
