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

ActiveRecord::Schema.define(version: 20160830152628) do

  create_table "answer_edits", force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "answer_id", null: false
    t.string  "body"
  end

  add_index "answer_edits", ["user_id", "answer_id"], name: "index_answer_edits_on_user_id_and_answer_id"

  create_table "answers", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.integer  "question_id",                     null: false
    t.text     "body",                            null: false
    t.boolean  "verified",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "comments_number", default: 0
  end

  add_index "answers", ["user_id", "question_id"], name: "index_answers_on_user_id_and_question_id"

  create_table "comments", force: :cascade do |t|
    t.text     "body",             null: false
    t.integer  "user_id",          null: false
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "favourites", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "question_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "favourites", ["user_id", "question_id"], name: "index_favourites_on_user_id_and_question_id"

  create_table "question_edits", force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "question_id", null: false
    t.string  "body"
  end

  add_index "question_edits", ["user_id", "question_id"], name: "index_question_edits_on_user_id_and_question_id"

  create_table "questions", force: :cascade do |t|
    t.string   "title",                                   null: false
    t.text     "body",                                    null: false
    t.string   "status",          default: "un_resolved"
    t.integer  "views",           default: 0
    t.integer  "user_id",                                 null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "comments_number", default: 0
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "tag_questions", force: :cascade do |t|
    t.integer  "tag_id",      null: false
    t.integer  "question_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tag_questions", ["tag_id", "question_id"], name: "index_tag_questions_on_tag_id_and_question_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "votable_id",   null: false
    t.string   "votable_type"
    t.boolean  "up_or_down"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id"
  add_index "votes", ["votable_id", "votable_type"], name: "index_votes_on_votable_id_and_votable_type"

end
