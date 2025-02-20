require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should have_many(:guesses).dependent(:destroy) }

  describe "creating an answer" do
    it "is invalid without text stating the answer" do
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
  end

  context "when the answer is correct" do
    it "can be checked with #correct?" do
      answer = build_stubbed(:correct_answer)
      expect(answer.correct?).to eq(true)
    end

    it "can be checked with #incorrect?" do
      answer = build_stubbed(:correct_answer)
      expect(answer.incorrect?).to eq(false)
    end
  end

  context "when the answer is incorrect" do
    it "can be checked with #correct?" do
      answer = build_stubbed(:incorrect_answer)
      expect(answer.correct?).to eq(false)
    end

    it "can be checked with #incorrect?" do
      answer = build_stubbed(:incorrect_answer)
      expect(answer.incorrect?).to eq(true)
    end
  end

  describe '#guessed_by(user)' do
    let(:answer) { create(:answer, times_guessed: 0) }

    it 'TODO: Checks if a Guess for this Answer exists for a User' do
      answer.guessed_by?(user)
      answer.reload
      expect(answer.times_guessed).to eq(1)
    end
  end

  describe '#times_guessed_as_percentage' do
    let(:answer) { create(:answer, times_guessed: 0) }

    it 'TODO: Calculates how many times this Answer has been guessed' do
      answer.times_guessed_as_percentage
      answer.reload
      expect(answer.times_guessed).to eq(1)
    end
  end

  describe '#increment_times_guessed!' do
    let(:answer) { create(:answer, times_guessed: 0) }

    it 'increments the times_guessed by 1' do
      answer.increment_times_guessed!
      answer.reload
      expect(answer.times_guessed).to eq(1)
    end
  end
end
