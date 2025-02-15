class QuestionsController < ApplicationController
  before_action :set_quiz, only: :show
  before_action :set_question, only: :show
  before_action :find_or_create_user_quiz, only: :show

  # GET /quizzes/:quiz_id/questions/:number
  def show
    @next_question = @quiz.questions.ordered.find_by(number: @question.number + 1)
    @previous_question = @quiz.questions.ordered.find_by(number: @question.number - 1)
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def set_quiz
    @question = @quiz.questions.find_by(number: params[:number].to_i)
  end

  def find_or_create_user_quiz
    UserQuiz.find_or_create_by(
      user: current_user,
      quiz: @quiz
    )
  end
end
