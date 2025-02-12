require 'rails_helper'

RSpec.describe Guess, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:answer) }

  # it "prevents duplicate votes for the same question per session" do
  #   incorrect_answer = create(:incorrect_answer, question: question)
  #   create(:guess, session_id: session_id, answer: incorrect_answer)

  #   # use create inside the block here because I couldn't figure out the exact error
  #   expect {
  #     create(:guess, session_id: session_id, answer: incorrect_answer)
  #   }.to raise_error(ActiveRecord::StatementInvalid, /duplicate key value violates unique constraint/)
  # end

  context 'when user tries to guess the same answer twice' do
    let(:user) { create(:user) }
    let(:answer) { create(:answer) }

    it 'prevents the same user from guessing the same answer multiple times' do
      create(:guess, user: user, answer: answer)

      duplicate_guess = build(:guess, user: user, answer: answer)

      expect(duplicate_guess).to_not be_valid
      expect(duplicate_guess.errors[:user_id]).to include('You can only guess an answer once')
    end
  end
end
