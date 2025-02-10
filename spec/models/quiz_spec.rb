require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should have_many(:questions).dependent(:destroy) }

  it "is invalid without a title" do
    quiz = build_stubbed(:quiz, title: nil)
    expect(quiz).not_to be_valid
  end
end
