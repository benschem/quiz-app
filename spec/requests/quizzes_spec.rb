

RSpec.describe "Quizzes", type: :request do
  describe "GET /quizzes" do
    it "returns http sucess" do
      # create_list(:quiz, 3)
      get quizzes_path
      expect(response).to have_http_status(:success)
      # add Capybara tests to test for actual content
    end
  end

  describe "GET /quizzes/:id" do
    it "returns http sucess" do
      quiz = create(:quiz)
      get quiz_path(quiz)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /quizzes/:id/start" do
    it "returns http success" do
      quiz = create(:quiz)
      get quiz_path(quiz)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /quizzes/:id/finish" do
    it "returns http redirect" do
      quiz = create(:quiz)
      post finish_quiz_path(quiz)
      expect(response).to have_http_status(:redirect)
    end
  end
end
