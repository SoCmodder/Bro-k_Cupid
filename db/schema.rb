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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131120181118) do

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.string   "location"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "time"
  end

  add_index "events", ["user_id", "created_at"], :name => "index_events_on_user_id_and_created_at"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id", "friend_id"], :name => "index_friendships_on_user_id_and_friend_id", :unique => true
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "posts", ["user_id", "created_at"], :name => "index_posts_on_user_id_and_created_at"

  create_table "questions", :force => true do |t|
    t.string   "text"
    t.string   "ans1"
    t.string   "ans2"
    t.string   "ans3"
    t.string   "ans4"
    t.string   "ans5"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "attendee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "importance"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
