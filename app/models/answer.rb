class Answer < ApplicationRecord
  belongs_to :question
  has_many :user_answers, dependent: :destroy

  validates :text, presence: true
  validates :correct, inclusion: { in: [true, false] }

  def correct?
    self.correct
  end

  def incorrect?
    !self.correct && !self.correct.nil?
  end
end
