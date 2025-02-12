class Answer < ApplicationRecord
  belongs_to :question
  has_many :guesses, dependent: :destroy

  validates :text, presence: true
  validates :correct, inclusion: { in: [true, false] }

  # Rails provdes this automatically
  # def correct?
  #   correct
  # end

  def incorrect?
    !correct && !correct.nil?
  end

  def increment_times_guessed
    # We still need this because the guesses table are based on sessions, not real users
    # Meaning we'lll probably clena out the user table regularly
    # This method might be called a lot!

    # Slowest option:
    # .save updates all fields
    # .save triggers validations and callbacks for the whole model

    # self.times_guessed += 1
    # self.save

    # Slower option:
    # update works like .save, but only updates the times_guessed field and immediately persists the change
    # update still triggers validations and callbacks for the whole model

    # update(:times_guessed, times_guessed + 1)

    # Fastest option:
    # update_column only updates the times_guessed field and immediately persists the change
    # update_column skips validations and callbacks altogether

    update_column(:times_guessed, times_guessed + 1)
  end
end
