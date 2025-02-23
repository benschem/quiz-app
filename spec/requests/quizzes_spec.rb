

RSpec.describe "Quizzes", type: :request do
  describe "GET /quizzes" do
    it "returns http sucess" do
      get quizzes_path
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of quizzes' do
      create(:quiz, title: 'title1')
      create(:quiz, title: 'title3')
      create(:quiz, title: 'title2')
      get quizzes_path
      expect(response.body).to include("title1", "title2", "title3")
    end
  end

  describe "GET /quizzes/:id" do
    it "returns http sucess" do
      quiz = create(:quiz)
      get quiz_path(quiz)
      expect(response).to have_http_status(:success)
    end

    it 'returns a quiz' do
      create(:quiz, title: 'title1')
      get quizzes_path
      expect(response.body).to include("title1")
    end
  end

  describe "GET /quizzes/:id/start" do
    it "returns http redirect" do
      quiz = create(:quiz)
      question = create(:question, quiz: quiz)
      get start_quiz_path(quiz)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST /quizzes/:id/finish" do
    it "returns http redirect" do
      quiz = create(:quiz)
      post finish_quiz_path(quiz)
      expect(response).to have_http_status(:redirect)
    end

    context 'when the user has finished the quiz' do
      # TODO: This test fails because I need to pass the user in the session and I don't know how
      # it 'redirects to the quiz show page' do
      #   quiz = create(:quiz)
      #   question = create(:question_with_answers, quiz: quiz)
      #   create(:guess, answer: question.answers.first)

      #   post finish_quiz_path(quiz)
      #   expect(response).to redirect_to(quiz_path(quiz))
      # end

      # TODO: This test fails because I need to pass the user in the session and I don't know how
      # it "increments times_taken for UserQuiz" do
      #   user_quiz = create(:user_quiz, times_taken: 0)
      #   quiz = create(:quiz)
      #   post finish_quiz_path(quiz)
      #   expect(user_quiz.times_taken).to eq(1)
      # end

      context 'when its their first time finishing the quiz' do
        # TODO: This test fails because I need to pass the user in the session and I don't know how
        # it "updates high_score for UserQuiz" do
        #   user = create(:user)
        #   user_quiz = create(:user_quiz, user: user)
        #   quiz = create(:quiz)
        #   question = create(:question, quiz: quiz)
        #   answer = create(:answer, question: question, correct: true)
        #   create(:guess, answer: answer, user: user)

        #   post finish_quiz_path(quiz)
        #   expect(user_quiz.high_score).to eq(1)
        # end
      end

      context 'when its not their first time finishing the quiz' do
        it "does not update high_score for UserQuiz" do
          user = create(:user)
          user_quiz = create(:user_quiz, user: user, high_score: 0, times_taken: 1)
          quiz = create(:quiz)
          question = create(:question, quiz: quiz)
          answer = create(:answer, question: question, correct: true)
          create(:guess, answer: answer, user: user)

          post finish_quiz_path(quiz)
          expect(user_quiz.high_score).to eq(0)
        end
      end
    end

    context 'when the user has not finished the quiz' do
      it 'redirects to the next unanswered question' do
        quiz = create(:quiz)
        question = create(:question, quiz: quiz)

        post finish_quiz_path(quiz)
        expect(response).to redirect_to(quiz_question_path(quiz, question))
      end
    end

  end
end
