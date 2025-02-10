require 'rails_helper'

RSpec.describe UserAnswer, type: :model do
  it { should belong_to(:answer) }

  it "is invalid without a session_id" do
    user_answer = UserAnswer.new(session_id: nil, answer: Answer.new(text: "Test", question: Question.new(text: "?", quiz: Quiz.new(title: "Test"))))
    expect(user_answer).not_to be_valid
  end

  it "prevents duplicate votes for the same question per session" do
    session_id = "12345"
    question = Question.create!(text: "Test?", quiz: Quiz.create!(title: "Quiz"))
    answer1 = Answer.create!(text: "A", question: question)
    answer2 = Answer.create!(text: "B", question: question)

    UserAnswer.create!(session_id: session_id, answer: answer1)

    duplicate_vote = UserAnswer.new(session_id: session_id, answer: answer2)
    expect(duplicate_vote).not_to be_valid
  end
end
