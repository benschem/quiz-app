require 'rails_helper'

RSpec.describe UserProgress, type: :model do
  it { should belong_to(:quiz) }
  it { should belong_to(:question) }

  # reminder: can't stub here, they need to be in the db
  let(:quiz) { create(:quiz) }
  let(:question) { create(:question_with_answers, quiz: quiz) }

  it "is invalid without a session_id" do
    user_progress = build(:user_progress, session_id: nil, quiz: quiz, question: question)
    expect(user_progress).not_to be_valid
  end

  it "defaults completed to false" do
    user_progress = build_stubbed(:user_progress)
    expect(user_progress.completed).to eq(false)
  end

  it "returns true for #completed? when the quiz is complete" do
    user_progress = build_stubbed(:complete_user_progress)
    expect(user_progress.completed?).to eq(true)
  end

  it "returns false for #completed? when the quiz is incomplete" do
    user_progress = build_stubbed(:incomplete_user_progress)
    expect(user_progress.completed?).to eq(false)
  end
end
