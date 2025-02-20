class QuestionsController < ApplicationController
  before_action :set_quiz, only: :show
  before_action :set_question, only: :show
  before_action :set_previous_question, only: :show
  before_action :set_next_question, only: :show
  before_action :set_user_quiz, only: :show

  # TODO: Questions should have a countdown timer that autosubmits no guess if the time runs out

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

  def set_previous_question
    previous_number = @question.number - 1
    if previous_number < 1
      @previous_question = nil
    else
      @previous_question = @quiz.questions.find_by(number: previous_number)
    end
  end

  def set_next_question
    next_number = @question.number + 1
    if next_number > @quiz.questions.length
      @next_question = nil
    else
      @next_question = @quiz.questions.find_by(number: next_number)
    end
  end
end
