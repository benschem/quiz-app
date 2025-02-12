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


  describe '#increment_times_guessed' do
  let(:answer) { create(:answer, times_guessed: 0) }

    it 'increments the times_guessed by 1' do
      answer.increment_times_guessed
      answer.reload
      expect(answer.times_guessed).to eq(1)
    end

    it 'does not trigger callbacks or validations' do
      allow(answer).to receive(:run_callbacks).and_call_original
      answer.increment_times_guessed
      expect(answer).not_to have_received(:run_callbacks)
    end
  end
end
