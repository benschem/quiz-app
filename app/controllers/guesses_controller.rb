class GuessesController < ApplicationController
  before_action :set_answer, only: :create
  before_action :set_question, only: :create
  before_action :set_quiz, only: :create
  before_action :set_user_quiz, only: :create

  # POST /quizzes/:quiz_id/questions/:question_number/guesses
  def create
    Guess.find_or_create_by(user: current_user, answer: @answer, user_quiz: @user_quiz)
    @answer.increment_times_guessed! unless user_has_taken_quiz_before

    if @answer.correct?
      flash[:notice] = "Correct!"
    else
      flash[:alert] = "Incorrect!"
    end

    redirect_to quiz_question_path(@quiz, @question)
  end

  private

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_user_quiz
    @user_quiz = UserQuiz.find_or_create_by(user: current_user, quiz: @quiz)
  end

  def user_has_taken_quiz_before
    @user_quiz.times_taken > 0
  end
end
