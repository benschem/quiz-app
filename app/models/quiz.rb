class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  validates :title, presence: true
end
