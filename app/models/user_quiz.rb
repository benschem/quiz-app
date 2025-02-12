class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :questions, through: :quiz
  has_many :guesses, through: :user

  def next_question
    # select the question with the highest "number" from the questions that the user has guessed
    # return the question with the next highest number
  end
end
