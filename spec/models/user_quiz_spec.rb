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

    # TODO: Add initial_score or first_time_score as well as high_score
    # Your score only counts for leaderboards etc the first time you take a quiz
  end

  describe "instance methods" do
    let!(:user) { create(:user) }
    let!(:quiz) { create(:quiz) }
    let!(:user_quiz) { create(:user_quiz, user: user, quiz: quiz) }

    let!(:question1) { create(:question, quiz: quiz) }
    let!(:answer1) { create(:correct_answer, question: question1) }
    let!(:answer2) { create(:incorrect_answer, question: question1) }

    let!(:question2) { create(:question, quiz: quiz, number: 2) }
    let!(:answer3) { create(:correct_answer, question: question2) }
    let!(:answer4) { create(:incorrect_answer, question: question2) }

    # Using let! ensures the guess is created before the test runs. Tests fail without this

    describe "#answered_questions" do
    it "returns questions the user has answered" do
        create(:guess, user: user, answer: answer1, user_quiz: user_quiz)
        expect(user_quiz.answered_questions).to contain_exactly(question1)
      end
    end

    describe "#unanswered_questions" do
      it "returns questions the user has not answered" do
        expect(user_quiz.unanswered_questions).to contain_exactly(question1, question2)
      end
    end

    describe "#correct_guesses_count" do
    it "returns the count of correctly answered questions" do
        create(:guess, user: user, answer: answer1, user_quiz: user_quiz)
        expect(user_quiz.correct_guesses_count).to eq(1)
      end
    end

    describe "#started?" do
      it "returns true if the user has answered at least one question" do
        create(:guess, user: user, answer: answer1, user_quiz: user_quiz)
        expect(user_quiz.started?).to be true
      end
    end

    describe "#finished?" do
      it "returns false if there are unanswered questions" do
        expect(user_quiz.finished?).to be false
      end

      it "returns true if all questions are answered" do
        create(:guess, user: user, answer: answer1, user_quiz: user_quiz)
        create(:guess, user: user, answer: answer3, user_quiz: user_quiz)
        expect(user_quiz.finished?).to be true
      end
    end

    describe "#next_unanswered_question" do
      it "returns the next unanswered question by order" do
        expect(user_quiz.next_unanswered_question).to eq(question1)
      end

    it "returns nil if all questions are answered" do
        create(:guess, user: user, answer: answer1, user_quiz: user_quiz)
        create(:guess, user: user, answer: answer3, user_quiz: user_quiz)
        user_quiz.reload
        expect(user_quiz.next_unanswered_question).to be_nil
      end
    end
  end
end
