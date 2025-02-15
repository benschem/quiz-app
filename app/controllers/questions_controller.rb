class QuestionsController < ApplicationController

  # GET /quizzes/:quiz_id/questions/:number
  def show
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find_by(number: params[:number].to_i)

    @next_question = @quiz.questions.ordered.find_by(number: @question.number + 1)
    @previous_question = @quiz.questions.ordered.find_by(number: @question.number - 1)

    UserQuiz.find_or_create_by(
      user: current_user,
      quiz: @quiz
    )
  end
end
