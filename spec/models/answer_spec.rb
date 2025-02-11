require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should have_many(:guesses).dependent(:destroy) }

  it "is invalid without text" do
    answer = build_stubbed(:correct_answer, text: nil)
    expect(answer).not_to be_valid
  end

  it "is invalid unless it specifies whether it's the correct answer" do
    answer = build_stubbed(:answer, correct: nil)
    expect(answer).not_to be_valid
  end

  it "defaults times_guessed to 0" do
    answer = build_stubbed(:answer)
    expect(answer.times_guessed).to eq(0)
  end

  it "returns true for #correct? when the answer is correct" do
    answer = build_stubbed(:correct_answer)
    expect(answer.correct?).to eq(true)
  end

  it "returns false for #correct? when the answer is incorrect" do
    answer = build_stubbed(:incorrect_answer)
    expect(answer.correct?).to eq(false)
  end

  it "returns true for #incorrect? when the answer is incorrect" do
    answer = build_stubbed(:incorrect_answer)
    expect(answer.incorrect?).to eq(true)
  end

  it "returns false for #incorrect? when the answer is correct" do
    answer = build_stubbed(:correct_answer)
    expect(answer.incorrect?).to eq(false)
  end
end
