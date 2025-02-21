require 'rails_helper'

RSpec.describe Guess, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:answer) }
  it { should belong_to(:user_quiz) }

  describe 'instance methods' do
    describe '#correct?' do
      context 'when the guess is correct' do
        let(:correct_answer) { create(:correct_answer) }
        let(:guess) { create(:guess, answer: correct_answer) }

        it 'returns true' do
          expect(guess.correct?).to be(true)
        end
      end

      context 'when the guess is incorrect' do
        let(:incorrect_answer) { create(:incorrect_answer) }
        let(:guess) { create(:guess, answer: incorrect_answer) }

        it 'returns false' do
          expect(guess).to respond_to(:correct?)
          expect(guess.correct?).to be(false)
        end
      end
    end
  end


  context 'when user tries to guess the same answer more than once' do
    let(:user) { create(:user) }
    let(:answer) { create(:answer) }

    it 'doesn\'t allow a multiple guesses for the same question and answer pair from the same user' do
      create(:guess, user: user, answer: answer)

      duplicate_guess = build(:guess, user: user, answer: answer)

      expect(duplicate_guess).to_not be_valid
      expect(duplicate_guess.errors[:user_id]).to include('You can only guess an answer once')
    end
  end
end
