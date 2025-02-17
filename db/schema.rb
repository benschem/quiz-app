# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_17_031338) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "text"
    t.boolean "correct"
    t.integer "times_guessed", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "guesses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "answer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_quiz_id", null: false
    t.index ["answer_id"], name: "index_guesses_on_answer_id"
    t.index ["user_id", "answer_id"], name: "index_guesses_on_user_and_answer", unique: true
    t.index ["user_id"], name: "index_guesses_on_user_id"
    t.index ["user_quiz_id"], name: "index_guesses_on_user_quiz_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.string "text"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_quizzes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "high_score"
    t.integer "times_taken", default: 0
    t.index ["quiz_id"], name: "index_user_quizzes_on_quiz_id"
    t.index ["user_id"], name: "index_user_quizzes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "guesses", "answers"
  add_foreign_key "guesses", "user_quizzes"
  add_foreign_key "guesses", "users"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "user_quizzes", "quizzes"
  add_foreign_key "user_quizzes", "users"
end
