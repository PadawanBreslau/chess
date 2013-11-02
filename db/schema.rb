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

ActiveRecord::Schema.define(version: 20131022200243) do

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
  end

end
