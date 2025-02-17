class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :user_quizzes
  has_many :users, through: :user_quizzes
  has_many :guesses, through: :questions

  validates :title, presence: true
end
