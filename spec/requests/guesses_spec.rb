require 'rails_helper'

RSpec.describe 'Guesses', type: :request do
  describe 'POST /quizzes/:quiz_id/questions/:id/guesses' do
    # TODO refactor to keep it DRY with let

    it 'returns http redirect' do
      quiz = create(:quiz)
      question = create(:question_with_answers, quiz: quiz)
      answer = question.answers.first

      post quiz_question_guesses_path(quiz, question), params: { answer_id: answer.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to the show page of the question just guessed' do
      quiz = create(:quiz)
      question = create(:question_with_answers, quiz: quiz)
      answer = question.answers.first

      post quiz_question_guesses_path(quiz, question), params: { answer_id: answer.id }
      expect(response).to redirect_to(quiz_question_path(quiz, question))
    end

    it 'creates a Guess' do
      quiz = create(:quiz)
      question = create(:question_with_answers, quiz: quiz)
      answer = question.answers.first

      expect {
        post quiz_question_guesses_path(quiz, question), params: { answer_id: answer.id }
      }.to change(Guess, :count).by(1)
    end

    context 'sets a flash message after making a guess' do
      it "sets the flash message to 'Correct!' if the guess was correct" do
        user = create(:user)
        quiz = create(:quiz)
        question = create(:question, quiz: quiz)
        answer = create(:answer, question: question, correct: true)

        post quiz_question_guesses_path(quiz, question), params: { answer_id: answer.id }
        expect(flash[:notice]).to eq('Correct!')
      end

      it "sets the flash message to 'Incorrect!' if the guess was incorrect" do
        user = create(:user)
        quiz = create(:quiz)
        question = create(:question, quiz: quiz)
        answer = create(:answer, question: question, correct: false)

        post quiz_question_guesses_path(quiz, question), params: { answer_id: answer.id }
        expect(request.flash[:alert]).to eq('Incorrect!')
      end
    end

    context 'when the user is taking the quiz for the first time' do
      it 'increments times_guessed on Answer by 1' do
        quiz = create(:quiz)
        user_quiz = create(:user_quiz, quiz: quiz, times_taken: 0)
        question = create(:question, quiz: quiz)
        answer = create(:answer, question: question, times_guessed: 0)

        post quiz_question_guesses_path(quiz, question), params: { answer_id: answer.id }
        expect(answer.reload.times_guessed).to eq(1)
      end
    end

    # TODO: This test fails because I need to pass the user in the session and I don't know how
    # context 'when the user is taking the quiz for the second+ time' do
    #   it 'does not increment times_guessed on Answer' do
    #     user = create(:user, session_id: SecureRandom.uuid)
    #     quiz = create(:quiz)
    #     user_quiz = create(:user_quiz, quiz: quiz, times_taken: 1)
    #     question = create(:question, quiz: quiz)
    #     answer = create(:answer, question: question, times_guessed: 0)

    #     post quiz_question_guesses_path(quiz, question), params: { answer_id: answer.id }
    #     # , headers: { "rack.session" => { user_id: user.id } }
    #     expect(answer.reload.times_guessed).to eq(0)
    #   end
    # end
  end
end
