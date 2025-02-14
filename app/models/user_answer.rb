class Guess < ApplicationRecord
  belongs_to :answer
  validates :answer, presence: true
  validates :session_id, presence: true
end
