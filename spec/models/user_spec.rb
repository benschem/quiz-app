require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:user_quizzes).dependent(:destroy) }
  it { should have_many(:quizzes).through(:user_quizzes).dependent(:destroy) }
  it { should have_many(:guesses).dependent(:destroy) }

  context "when creating a user" do
    it "is invalid without a session_id" do
      user = build_stubbed(:user, session_id: nil)
      expect(user).not_to be_valid
    end
  end
end
