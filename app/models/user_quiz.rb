# Describes one users' relationship to one quiz
class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :guesses

  # Returns the questions for the quiz that have been answered by the user
  def answered_questions
    quiz.questions
        .joins(answers: :guesses)
        .where(guesses: { user: user })
        .distinct
  end

  # Returns the questions for the quiz that have not been answered by the user
  def unanswered_questions
    quiz.questions.where.not(id: answered_questions.select(:id))
  end

  # Returns how many questions the user answered corerctly for the quiz
  def correct_guesses_count
    guesses.joins(answer: :question)
            .where(answers: { correct: true })
            .count
  end

  def started?
    answered_questions.count > 0
  end

  def finished?
    answered_questions.count == quiz.questions.count
  end

  def next_unanswered_question
    unanswered_questions.order(:number).first unless unanswered_questions.empty?
  end
end
