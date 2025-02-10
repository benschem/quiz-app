require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:quiz) }
  it { should have_many(:answers).dependent(:destroy) }

  it "is invalid without text" do
    question = Question.new(text: nil, quiz: Quiz.new(title: "Test Quiz"))
    expect(question).not_to be_valid
  end
end
