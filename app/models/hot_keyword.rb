class HotKeyword < ActiveRecord::Base
  belongs_to :company
  default_scope { order("created_at desc") }
end
