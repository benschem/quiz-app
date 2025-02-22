require 'rails_helper'
require 'debug'

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

  describe 'instance methods' do
    describe '#correct?' do
      context "when the answer is correct" do
        it "returns true" do
          answer = build_stubbed(:correct_answer)
          expect(answer.correct?).to be(true)
        end
      end
      context "when the answer is incorrect" do
        it "returns false" do
          answer = build_stubbed(:incorrect_answer)
          expect(answer.correct?).to be(false)
        end
      end
    end


    describe '#incorrect?' do
      context "when the answer is correct" do
        it "returns false" do
          answer = build_stubbed(:correct_answer)
          expect(answer.incorrect?).to be(false)
        end
      end

      context "when the answer is incorrect" do
        it "returns true" do
          answer = build_stubbed(:incorrect_answer)
          expect(answer.incorrect?).to be(true)
        end
      end
    end

    describe '#guessed_by(user)' do
      context "when a Guess for this Answer exists for a User" do
        let(:user) { create(:user) }
        let(:answer) { create(:answer) }
        let!(:guess) { create(:guess, answer: answer, user: user) }

        it 'returns true' do
          expect(answer.guessed_by?(user)).to be(true)
        end
      end

      context "when a Guess for this Answer does not exist for a User" do
        let(:user) { create(:user) }
        Guess.destroy_all
        let(:answer) { create(:answer) }

        it 'returns false' do
          expect(answer.guessed_by?(user)).to be(false)
        end
      end
    end

    describe '#times_guessed_as_percentage' do
      let!(:question) { create(:question)}
      let!(:answer1) { create(:answer, question: question, times_guessed: 5) }
      let!(:answer2) { create(:answer, question: question, times_guessed: 5) }

      it 'returns a float between 0 and 100' do
        # binding.break
        expect(answer1.times_guessed_as_percentage).to eq(50.0)
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

end
