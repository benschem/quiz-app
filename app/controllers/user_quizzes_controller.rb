class UserQuizzesController < ApplicationController
  before_action :set_user_quiz, only: :replay
  before_action :set_quiz, only: :replay

  def replay
    delete_guesses_from_last_play
    redirect_to start_quiz_path(@quiz)
  end

  private

  def set_user_quiz
    @user_quiz = UserQuiz.find(params[:id])
  end

  def set_quiz
    @quiz = @user_quiz.quiz
  end

  def delete_guesses_from_last_play
    @user_quiz.guesses.destroy_all
  end
end
