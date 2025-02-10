require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should have_many(:user_answers).dependent(:destroy) }

  it "is invalid without text" do
    answer = Answer.new(text: nil, question: Question.new(text: "Test?", quiz: Quiz.new(title: "Test Quiz")))
    expect(answer).not_to be_valid
  end

  it "defaults times_guessed to 0" do
    answer = Answer.create!(text: "Test", question: Question.new(text: "Test?", quiz: Quiz.new(title: "Test Quiz")))
    expect(answer.times_guessed).to eq(0)
  end
end
