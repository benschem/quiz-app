class Guess < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  belongs_to :user_quiz

  validates :user_id, uniqueness: { scope: :answer_id, message: "You can only guess an answer once" }

  def correct?
    answer.correct?
  end
end
