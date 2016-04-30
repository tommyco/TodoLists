class TodoItem < ActiveRecord::Base
  belongs_to :todo_list

  scope :has_completed, -> { where(completed: true) }
  default_scope { order :due_date }
end
