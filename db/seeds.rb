# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "Deleting answers..."
Answer.delete_all
puts "Deleting questions..."
Question.delete_all
puts "Deleting quizzes..."
Quiz.delete_all

puts "Creating a quiz about winter sports..."
winter_sports_quiz = Quiz.create(title: "Winter Sports")

10.times do |index|
  question = Question.create(
    text: "Which one is a winter sport?",
    quiz_id: winter_sports_quiz.id,
    number: index + 1
  )
end

winter_sports_quiz.questions.each do |question|
  4.times do
    incorrect_answer = Answer.create(
      text: Faker::Sport.summer_olympics_sport,
      question_id: question.id,
      correct: false
    )
  end

  correct_answer = question.answers.sample
  correct_answer.text = Faker::Sport.winter_olympics_sport
  correct_answer.correct = true
  correct_answer.save
end


puts "Creating a quiz about Community vs New Girl..."
tv_show_quiz = Quiz.create(title: "Community vs New Girl")

10.times do |index|
  question = Question.create(
    text: "Which quote is from Community?",
    quiz: tv_show_quiz,
    number: index + 1
  )
end

tv_show_quiz.questions.each do |question|
  4.times do
    incorrect_answer = Answer.create(
      text: Faker::TvShows::NewGirl.quote,
      question_id: question.id,
      correct: false
    )
  end

  correct_answer = question.answers.sample
  correct_answer.text = Faker::TvShows::Community.quotes
  correct_answer.correct = true
  correct_answer.save
end
