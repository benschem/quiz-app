require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  describe 'GET /quizzes/:quiz_id/questions/:id' do
    it 'returns http success' do
      quiz = create(:quiz)
      question = create(:question, quiz: quiz)
      get quiz_question_path(quiz, question)
      expect(response).to have_http_status(:success)
    end
  end
end
