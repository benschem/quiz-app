class GuessesController < ApplicationController
  before_action :set_quiz, only: :create
  before_action :set_question, only: :create
  before_action :find_or_create_user_quiz, only: :create

  # POST /quizzes/:quiz_id/questions/:question_number/guesses
  def create
    answer = Answer.find(params[:answer_id])
    guess = answer.guesses.find_or_create_by(user: current_user, answer: answer)

    answer.increment_times_guessed! unless @user_quiz.times_taken > 1
    flash[:notice] = answer.correct? ? "Correct!" : "Incorrect!"

    redirect_to quiz_question_path(@quiz, @question.number)
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = @quiz.questions.find_by(number: params[:question_number].to_i)

  end

  def find_or_create_user_quiz
    @user_quiz = UserQuiz.find_or_create_by(user: current_user, quiz: @quiz)
  end
end
