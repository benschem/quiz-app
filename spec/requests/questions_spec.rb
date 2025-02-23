require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  describe 'GET /quizzes/:quiz_id/questions/:id' do
    it 'returns http success' do
      quiz = create(:quiz)
      question = create(:question, quiz: quiz)

      get quiz_question_path(quiz, question)
      expect(response).to have_http_status(:success)
    end

    # TODO: This test fails because I need to pass the user in the session and I don't know how
    # it 'sets the next question' do
    #   quiz = create(:user)
    #   quiz = create(:quiz)
    #   question1 = create(:question, quiz: quiz, number: 1)
    #   question2 = create(:question_with_answers, quiz: quiz, number: 2)
    #   question3 = create(:question, quiz: quiz, number: 3)
    #   create(:guess, answer: question2.answers.first, user: user) # next question only appears after you have guessed

    #   get quiz_question_path(quiz, question2)
    #   expect(response.body).to include("href=\"/quizzes/#{quiz.id}/questions/#{question3.id}\"")
    # end

    it 'sets the previous question' do
      quiz = create(:quiz)
      question1 = create(:question, quiz: quiz, number: 1)
      question2 = create(:question, quiz: quiz, number: 2)
      question3 = create(:question, quiz: quiz, number: 3)

      get quiz_question_path(quiz, question2)
      expect(response.body).to include("href=\"/quizzes/#{quiz.id}/questions/#{question1.id}\"")
    end
  end
end
