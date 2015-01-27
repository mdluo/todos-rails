class Todo < ActiveRecord::Base
  validates :task, length: { in: 1..100 }
end
