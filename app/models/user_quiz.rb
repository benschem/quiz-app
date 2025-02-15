class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :questions, through: :quiz
  has_many :guesses, through: :user
end
