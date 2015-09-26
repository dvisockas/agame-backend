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

ActiveRecord::Schema.define(version: 20150926145213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "estate_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind",         null: false
    t.float    "cost"
    t.float    "health"
    t.float    "health_regen"
    t.float    "build_time"
    t.integer  "level"
  end

  create_table "estates", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estate_type_id"
    t.float    "health"
  end

  add_index "estates", ["estate_type_id"], name: "index_estates_on_estate_type_id", using: :btree
  add_index "estates", ["player_id"], name: "index_estates_on_player_id", using: :btree

  create_table "player_resources", force: :cascade do |t|
    t.integer  "kind"
    t.integer  "player_id"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_resources", ["player_id"], name: "index_player_resources_on_player_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
