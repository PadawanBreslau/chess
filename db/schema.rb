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

ActiveRecord::Schema.define(version: 20140110192526) do

  create_table "article_photos", force: true do |t|
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "articles", force: true do |t|
    t.integer  "site_user_id"
    t.string   "title"
    t.string   "lead"
    t.string   "summary"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_entries", force: true do |t|
    t.integer "site_user_id"
    t.string  "title"
    t.text    "content"
  end

  create_table "blog_entry_photos", force: true do |t|
    t.integer  "blog_entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "event_name"
    t.string   "url"
    t.datetime "event_start"
    t.datetime "event_finish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fide_ratings", force: true do |t|
    t.integer "rating"
    t.integer "fide_id"
    t.integer "year"
    t.integer "month"
  end

  create_table "games", force: true do |t|
    t.datetime "date"
    t.integer  "white_player_id"
    t.integer  "black_player_id"
    t.integer  "result"
    t.string   "eco"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "middlename"
    t.string   "surname"
    t.integer  "fide_id"
    t.date     "date_of_birth"
    t.integer  "site_user_id"
    t.integer  "player_photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "rounds", force: true do |t|
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
    t.integer  "round_number"
  end

  create_table "site_comments", force: true do |t|
    t.integer  "site_user_id",     null: false
    t.string   "content",          null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_user_informations", force: true do |t|
    t.integer  "site_user_id"
    t.string   "name"
    t.string   "surname"
    t.string   "nick"
    t.date     "date_of_birth"
    t.float    "reputation",     default: 0.0
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_active_at"
  end

  create_table "site_users", force: true do |t|
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_user_information_id"
  end

  add_index "site_users", ["email"], name: "index_site_users_on_email", unique: true, using: :btree
  add_index "site_users", ["reset_password_token"], name: "index_site_users_on_reset_password_token", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tournaments", force: true do |t|
    t.string   "tournament_name"
    t.datetime "tournament_start"
    t.datetime "tournament_finish"
    t.integer  "round_number"
    t.boolean  "is_finished"
    t.string   "place"
    t.string   "url"
    t.string   "external_transmition_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

end
