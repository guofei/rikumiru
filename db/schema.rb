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

ActiveRecord::Schema.define(version: 20150630150427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "alice_name"
    t.integer  "tweet_id",     limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tweet_count"
    t.text     "description"
    t.integer  "sub_index_id"
  end

  add_index "companies", ["sub_index_id"], name: "index_companies_on_sub_index_id", using: :btree

  create_table "hot_keywords", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.boolean  "useful",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recent_day"
  end

  add_index "hot_keywords", ["company_id"], name: "index_hot_keywords_on_company_id", using: :btree

  create_table "keyword_indices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tweet_count"
    t.integer  "keyword_index_id"
  end

  add_index "keywords", ["keyword_index_id"], name: "index_keywords_on_keyword_index_id", using: :btree

  create_table "mailmagas", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "keyword_id"
  end

  add_index "mailmagas", ["company_id"], name: "index_mailmagas_on_company_id", using: :btree
  add_index "mailmagas", ["keyword_id"], name: "index_mailmagas_on_keyword_id", using: :btree

  create_table "main_indices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "sub_indices", force: true do |t|
    t.string   "name"
    t.integer  "main_index_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_indices", ["main_index_id"], name: "index_sub_indices_on_main_index_id", using: :btree

  create_table "tweets", force: true do |t|
    t.integer  "company_id"
    t.string   "text"
    t.string   "username"
    t.boolean  "useful"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.boolean  "bayesfilter"
    t.integer  "user_vote"
    t.float    "emotion_score"
    t.string   "profile_img"
    t.integer  "keyword_id"
  end

  add_index "tweets", ["company_id"], name: "index_tweets_on_company_id", using: :btree
  add_index "tweets", ["created_at"], name: "index_tweets_on_created_at", using: :btree
  add_index "tweets", ["keyword_id"], name: "index_tweets_on_keyword_id", using: :btree

  create_table "users", force: true do |t|
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
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
