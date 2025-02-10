require 'rails_helper'

RSpec.describe UserAnswer, type: :model do
  it { should belong_to(:answer) }

  let(:quiz) { build_stubbed(:quiz) }
  let(:question) { build_stubbed(:question, quiz: quiz) }
  let(:answer1) { build_stubbed(:answer, question: question) }
  let(:answer2) { build_stubbed(:answer, question: question) }
  let(:session_id) { "12345" }

  it "is invalid without a session_id" do
    user_answer = build_stubbed(:user_answer, session_id: nil, answer: answer1)
    expect(user_answer).not_to be_valid
  end

  it "prevents duplicate votes for the same question per session" do
    create(:user_answer, session_id: session_id, answer: answer1)

    duplicate_vote = build(:user_answer, session_id: session_id, answer: answer2)
    expect(duplicate_vote).not_to be_valid
  end
end
