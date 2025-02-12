require 'rails_helper'

RSpec.describe UserQuiz, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:quiz) }
  it { should have_many(:questions).through(:quiz)dependent(:destroy) }
end
