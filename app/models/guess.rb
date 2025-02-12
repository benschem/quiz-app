class Guess < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :user_id, uniqueness: { scope: :answer_id, message: "You can only guess an answer once" }

  def correct?
    answer.correct?
  end
end
