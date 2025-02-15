class QuizzesController < ApplicationController
  before_action :set_quiz, only: :show
  before_action :find_or_create_user_quiz, only: :show

  # GET /quizzes
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/:id
  def show
    if @quiz.finished_by?(current_user)
      @user_quiz.times_taken += 1
      update_high_score
      @user_quiz.save
    end
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

  def update_high_score
    score = @user_quiz.guesses.count { |guess| guess.correct? }


    if @user_quiz.high_score.nil? || score > @user_quiz.high_score
      @user_quiz.high_score = score
    end
  end
end
