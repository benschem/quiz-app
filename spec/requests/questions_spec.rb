require 'rails_helper'

RSpec.describe "Questions", type: :request do
  describe "GET /questions/:id" do
    it "returns http success" do
      get "/questions/show"
      expect(response).to have_http_status(:success)
    end
  end

end
