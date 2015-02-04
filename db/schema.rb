# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20150203083607) do
=======
ActiveRecord::Schema.define(version: 20150203133552) do
>>>>>>> upstream/master

  create_table "assignments", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "placement"
  end

  add_index "assignments", ["step_id"], name: "index_assignments_on_step_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "msg"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["category_id"], name: "index_comments_on_category_id"

  create_table "examinations", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "examinations", ["category_id"], name: "index_examinations_on_category_id"

  create_table "guides", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "placement"
  end

  add_index "guides", ["step_id"], name: "index_guides_on_step_id"

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.string   "option1"
    t.string   "option2"
    t.string   "answer"
    t.integer  "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["quiz_id"], name: "index_questions_on_quiz_id"

  create_table "quizzes", force: :cascade do |t|
    t.string   "name"
    t.integer  "step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "placement"
  end

  add_index "quizzes", ["step_id"], name: "index_quizzes_on_step_id"

  create_table "steps", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "placement"
  end

  add_index "steps", ["category_id"], name: "index_steps_on_category_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "completion"
    t.string   "email"
    t.string   "uid"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "admin"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "placement"
  end

  add_index "videos", ["step_id"], name: "index_videos_on_step_id"

end
