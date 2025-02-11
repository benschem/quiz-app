require 'rails_helper'

RSpec.describe Guess, type: :model do
  it { should belong_to(:answer) }

  # reminder: can't stub here, they need to be in the db
  let(:quiz) { create(:quiz) }
  let(:question) { create(:question_with_answers, quiz: quiz) }
  let(:answer) { create(:answer, correct: true) }
  let(:session_id) { "12345" }

  it "is invalid without a session_id" do
    guess = build(:guess, session_id: nil, answer: answer)
    expect(guess).not_to be_valid
  end

  it "prevents duplicate votes for the same question per session" do
    incorrect_answer = create(:incorrect_answer, question: question)
    create(:guess, session_id: session_id, answer: incorrect_answer)

    # use create inside the block here because I couldn't figure out the exact error
    expect {
      create(:guess, session_id: session_id, answer: incorrect_answer)
    }.to raise_error(ActiveRecord::StatementInvalid, /duplicate key value violates unique constraint/)
  end
end
