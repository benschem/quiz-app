class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :user_quizzes
  has_many :users, through: :user_quizzes

  validates :title, presence: true

  def started_by?(user)
    user.guesses.exists?
  end

  def finished_by?(user)
    answered_question_ids = user.guesses.includes(:answer).pluck("answers.question_id")
    unanswered_questions = questions.where.not(id: answered_question_ids)
    unanswered_questions.none?
  end

  def next_question_for(user)
    return nil if finished_by?(user)

    answered_question_ids = user.guesses.includes(:answer).pluck("answers.question_id")
    unanswered_questions = questions.where.not(id: answered_question_ids)
    unanswered_questions.ordered.first
  end
end
