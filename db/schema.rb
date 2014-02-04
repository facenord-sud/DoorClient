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

ActiveRecord::Schema.define(version: 20140201161534) do

  create_table "doors", force: true do |t|
    t.string   "uri"
    t.string   "lock_uri"
    t.string   "open_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locks", force: true do |t|
    t.string   "state"
    t.integer  "door_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locks", ["door_id"], name: "index_locks_on_door_id"

  create_table "opens", force: true do |t|
    t.integer  "position"
    t.string   "state"
    t.integer  "door_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opens", ["door_id"], name: "index_opens_on_door_id"

end
