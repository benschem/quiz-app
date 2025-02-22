require 'rails_helper'

RSpec.describe 'Guesses', type: :request do
  describe 'POST /quizzes/:quiz_id/questions/:id/guesses' do
    # TODO: This returns a 404 and at that break point the path does not exist
    # But it shows in rails routes soooo nfi
    it 'returns http redirect' do
      quiz = create(:quiz)
      question = create(:question_with_answers, quiz: quiz)
      answer = question.answers.first  # Assuming answers exist

      post quiz_question_guesses_path(quiz, question), params: { answer_id: answer.id }
      expect(response).to have_http_status(:redirect)
    end
  end
end
