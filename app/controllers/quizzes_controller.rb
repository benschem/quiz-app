class QuizzesController < ApplicationController
  before_action :set_quiz, only: :show
  before_action :find_or_create_user_quiz, only: :show

  # GET /quizzes
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/:id
  def show
    @user_quiz.update(times_taken: times_taken += 1) if @quiz.completed_by?(current_user)
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def find_or_create_user_quiz
    @user_quiz = UserQuiz.find_or_create_by(
      user: current_user,
      quiz: @quiz
    )
  end
end
