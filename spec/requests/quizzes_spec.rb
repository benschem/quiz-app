require 'rails_helper'

RSpec.describe "Quizzes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      # create_list(:quiz, 3)
      get quizzes_path
      expect(response).to have_http_status(:success)
      # add Capybara tests to test for actual content
    end
  end

  describe "GET /show" do
    it "returns http success" do
      quiz = create(:quiz)
      get quiz_path(quiz)
      expect(response).to have_http_status(:success)
    end
  end
end
