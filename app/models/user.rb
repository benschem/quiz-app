class User < ApplicationRecord
  has_many :quizzes, through: :user_quiz, dependent: :destroy

  validates :session_id, presence: true
end
