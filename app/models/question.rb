class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy
  has_many :guesses, through: :answers, dependent: :destroy

  scope :ordered, -> { order(:number) }

  validates :text, presence: true
  validates :number, presence: true
  validate :must_have_exactly_one_correct_answer, on: :update # allows creating an answer after a question

  def guessed_by?(user)
    guesses.exists?(user: user)
  end

  private

  def must_have_exactly_one_correct_answer
    correct_answers = answers.select(&:correct)

    if correct_answers.count != 1
      errors.add(:answers, "must have exactly one correct answer")
    end
  end
end
