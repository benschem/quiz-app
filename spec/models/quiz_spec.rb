require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:user_quizzes) }
  it { should have_many(:users).through(:user_quizzes) }
  it { should have_many(:guesses).through(:questions) }

  let(:quiz) { build_stubbed(:quiz) }

  context "creating a quiz" do
    it "is invalid without a title" do
      quiz.title = nil
      expect(quiz).not_to be_valid
    end
  end
end
