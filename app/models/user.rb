class User < ApplicationRecord
  has_many :user_quizzes, dependent: :destroy
  has_many :quizzes, through: :user_quizzes, dependent: :destroy
  has_many :guesses, dependent: :destroy

  validates :session_id, presence: true

  # TODO: Users should be able to create accounts
  # TODO: Users should be able to add each other as friends
end
