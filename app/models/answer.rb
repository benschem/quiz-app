class Answer < ApplicationRecord
  belongs_to :question
  has_many :guesses, dependent: :destroy

  validates :text, presence: true
  validates :correct, inclusion: { in: [true, false] }

  # Rails provdes this automatically for boolean columns
  # def correct?
  #   correct
  # end

  def incorrect?
    !correct && !correct.nil?
  end

  def guessed_by?(user)
    guesses.exists?(user: user)
  end

  def increment_times_guessed!
    # We still need a times_guessed column here because we can't count how many guesses there are since
    # our users table is based on sessions, not real users, meaning we'll probably clean out old "users" regularly,
    # so we can't rely on a calculation for this

    # This is essentially a "global" method and might be called a lot!
    # So we need to make sure it's efficient
    # There are a few different approaches:

    # Slowest & not atomic:
    # - Loads the record into memory, modifies the attribute
    # - Requires .save to persist changes
    # - .save updates all columns, not just times_guessed
    # - Triggers validations and callbacks (for the entire model)
    # self.times_guessed += 1
    # self.save

    # Slower & not atomic:
    # - Loads the record into memory, modifies the attribute, then calls .save!
    # - Only updates times_guessed column, not all columns
    # - Triggers validations and callbacks (but only for times_guessed)
    # update(times_guessed: times_guessed += 1)

    # Slower & not atomic:
    # - Loads the record into memory, modifies the attribute, then calls .save!
    # - Only updates times_guessed column, not all columns
    # - Triggers validations and callbacks (but only for times_guessed)
    # increment!(:times_guessed)

    # Faster & not atomic:
    # - Direct SQL update, bypasses ActiveRecord validations and callbacks
    # - Still not atomic so doesn't prevent race conditions
    # update_column(:times_guessed, times_guessed += 1)

    # Fastest & atomic:
    # - Direct SQL update, bypassing ActiveRecord entirely
    # - Fully atomic, so no race conditions
    # - No callbacks or validations triggered
    # Answer.update_counters(id, times_guessed: 1)
    # or
    Answer.increment_counter(:times_guessed, id)
  end
end
