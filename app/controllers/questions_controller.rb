class QuestionsController < ApplicationController
  before_action :set_quiz, only: :show
  before_action :set_question, only: :show
  before_action :set_user_quiz, only: :show

  # GET /quizzes/:quiz_id/questions/:id
  def show
  end

  private

  def set_quiz
    @quiz = Quiz.includes(:questions).find(params[:quiz_id])
  end

  def set_question
    @question = @quiz.questions.find(params[:id])
  end

  def set_user_quiz
    @user_quiz = UserQuiz.find_or_create_by(
      user: current_user,
      quiz: @quiz
    )
  end
end
