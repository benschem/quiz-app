require 'rails_helper'

RSpec.describe Guess, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:answer) }
  it { should belong_to(:user_quiz) }

  # it "prevents duplicate votes for the same question per session" do
  #   incorrect_answer = create(:incorrect_answer, question: question)
  #   create(:guess, session_id: session_id, answer: incorrect_answer)

  #   # use create inside the block here because I couldn't figure out the exact error
  #   expect {
  #     create(:guess, session_id: session_id, answer: incorrect_answer)
  #   }.to raise_error(ActiveRecord::StatementInvalid, /duplicate key value violates unique constraint/)
  # end

  context 'when the guess is correct' do
    let(:correct_answer) { create(:correct_answer) }
    let(:guess) { create(:guess, answer: correct_answer) }

    it 'can be accurately checked' do
      expect(guess).to respond_to(:correct?)
      expect(guess.correct?).to eq(true)
    end
  end

  context 'when the guess is incorrect' do
    let(:incorrect_answer) { create(:incorrect_answer) }
    let(:guess) { create(:guess, answer: incorrect_answer) }

    it 'can be accurately checked' do
      expect(guess).to respond_to(:correct?)
      expect(guess.correct?).to eq(false)
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
