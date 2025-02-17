class QuizzesController < ApplicationController
  before_action :set_quiz, except: :index
  before_action :set_user_quiz, except: :index
  before_action :set_next_question, only: :start

  # GET /quizzes
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/:id
  def show
  end

  # GET /quizzes/:id/start
  def start
    redirect_to quiz_question_path(@quiz, @next_question)
  end

  # POST /quizzes/:id/finish
  def finish
    if @user_quiz.finished?
      @user_quiz.times_taken += 1
      new_score = @user_quiz.correct_guesses_count
      @user_quiz.high_score = new_score if first_time_taken || new_score > @user_quiz.high_score
      @user_quiz.save

      redirect_to quiz_path(@quiz)
    else
      redirect_to quiz_question_path(@quiz, @user_quiz.next_question)
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def set_user_quiz
    @user_quiz = UserQuiz.find_or_create_by(
      user: current_user,
      quiz: @quiz
    )
  end

  def set_next_question
    if @user_quiz.started?
      @next_question = @user_quiz.next_question
    else
      @next_question = @quiz.questions.ordered.first
    end
  end

  def first_time_taken
    @user_quiz.high_score.nil?
  end
end
