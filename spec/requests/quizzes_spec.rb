

RSpec.describe "Quizzes", type: :request do
  describe "GET /quizzes" do
    it "loads a list of quizzes" do
      # create_list(:quiz, 3)
      get quizzes_path
      expect(response).to have_http_status(:success)
      # add Capybara tests to test for actual content
    end
  end

  describe "GET /quizzes/:id" do
    it "loads a specific quiz" do
      quiz = create(:quiz)
      get quiz_path(quiz)
      expect(response).to have_http_status(:success)
    end
  end
end
