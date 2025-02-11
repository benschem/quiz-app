class UserProgress < ApplicationRecord
  belongs_to :quiz
  belongs_to :question

  validates :session_id, presence: true
  validates :completed, inclusion: { in: [true, false] }

  def completed?
    self.completed
  end
end
