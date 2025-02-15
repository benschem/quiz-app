class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/:id
  # Show an indivual quiz overview
  # Start quiz button unless quiz already completed
  # If completed, show stats and give redo option
  def show
    @quiz = Quiz.find(params[:id])

    UserQuiz.find_or_create_by(
      user: current_user,
      quiz: @quiz
    )

    # use this in the view
    # if @quiz.completed_by?(current_user)
  end
end
