# require 'debug'
require 'rails_helper'

RSpec.describe UserQuiz, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:quiz) }
  it { should have_many(:guesses) }

  describe "creating a user_quiz" do
    let(:user_quiz) { build_stubbed(:user_quiz) }

    it "defaults times_taken to 0" do
      expect(user_quiz.times_taken).to eq(0)
    end

    it "defaults high_score to 0" do
      expect(user_quiz.high_score).to eq(0)
    end
  end

  describe "instance methods" do
    let(:user) { create(:user) }
    let(:quiz) { create(:quiz) }
    let(:user_quiz) { create(:user_quiz, user: user, quiz: quiz) }

    let(:question1) { create(:question_with_answers, quiz: quiz) }
    let(:question2) { create(:question_with_answers, quiz: quiz, number: 2) }

    let(:guess) { create(:guess, user: user, answer: question1.answers.first, user_quiz: user_quiz) }

    describe "#answered_questions" do
      it "returns questions the user has answered" do
        expect(user_quiz.answered_questions).to contain_exactly(question1)
      end
    end

    describe "#unanswered_questions" do
      it "returns questions the user has not answered" do
        expect(user_quiz.unanswered_questions).to contain_exactly(question2)
      end
    end

    describe "#correct_guesses_count" do
    it "returns the count of correctly answered questions" do
      # binding.break
        expect(user_quiz.correct_guesses_count).to eq(1)
      end
    end

    describe "#started?" do
      it "returns true if the user has answered at least one question" do
        expect(user_quiz.started?).to be true
      end
    end

    describe "#finished?" do
      it "returns false if there are unanswered questions" do
        expect(user_quiz.finished?).to be false
      end

      it "returns true if all questions are answered" do
        create(:guess, user: user, answer: answer2, user_quiz: user_quiz)
        expect(user_quiz.finished?).to be true
      end
    end

    describe "#next_unanswered_question" do
      it "returns the next unanswered question by order" do
        expect(user_quiz.next_unanswered_question).to eq(question2)
      end

      it "returns nil if all questions are answered" do
        create(:guess, user: user, answer: answer2)
        expect(user_quiz.next_unanswered_question).to be_nil
      end
    end
  end
end
