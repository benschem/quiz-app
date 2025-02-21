require 'rails_helper'

RSpec.describe "UserQuizzes", type: :request do
  describe "PATCH /replay" do
    it "returns http redirect" do
      user_quiz = create(:user_quiz)
      patch replay_user_quiz_path(user_quiz)
      expect(response).to have_http_status(:redirect)
    end
  end

end
