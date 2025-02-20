require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:quiz) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:guesses).through(:answers).dependent(:destroy) }

  context "when creating a question" do
    let(:question) { create(:question_with_answers) }

    it "is invalid without the text of the question" do
      question.text = nil
      expect(question).not_to be_valid
    end

    it "is invalid without a correct answer" do
      question.answers.destroy_all
      create(:incorrect_answer, question: question)

      expect(question).not_to be_valid
      expect(question.errors[:answers]).to include("must have exactly one correct answer")
    end

    it "is invalid with multiple correct answers" do
      question.answers.destroy_all
      create(:correct_answer, question: question)
      create(:correct_answer, question: question)

      expect(question).not_to be_valid
      expect(question.errors[:answers]).to include("must have exactly one correct answer")
    end

    it "is valid with exactly one correct answer" do
      expect(question.answers.count).to be >= 2

      expect(question).to be_valid
    end
  end

end
