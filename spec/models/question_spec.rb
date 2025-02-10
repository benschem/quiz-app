require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:quiz) }
  it { should have_many(:answers).dependent(:destroy) }

  it "is invalid without text" do
    question = build_stubbed(:question, text: nil)
    expect(question).not_to be_valid
  end
end
