class UserProblem < ApplicationRecord
  belongs_to :user
  belongs_to :problem

  # You might have a status column (like "not_started", "in_progress", "completed")
  # For convenience, you can use an enum:
  enum status: { not_started: 0, in_progress: 1, completed: 2 }
end