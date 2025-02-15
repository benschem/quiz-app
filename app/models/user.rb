class User < ApplicationRecord
  has_many :user_quizzes, dependent: :destroy
  has_many :quizzes, through: :user_quizzes, dependent: :destroy
  has_many :guesses, dependent: :destroy

  validates :session_id, presence: true
end
