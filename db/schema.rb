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

ActiveRecord::Schema.define(version: 20151214055855) do

  create_table "accounts", force: :cascade do |t|
    t.boolean  "admin",             default: false
    t.boolean  "approved",          default: false
    t.string   "display_name",                      null: false
    t.string   "email",                             null: false
    t.datetime "last_logged_in_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "connect_facebooks", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "identifier"
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "connect_facebooks", ["identifier"], name: "index_connect_facebooks_on_identifier", unique: true

  create_table "event_members", force: :cascade do |t|
    t.integer  "event_id",   null: false
    t.integer  "member_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_members", ["event_id", "member_id"], name: "index_event_members_on_event_id_and_member_id", unique: true

  create_table "events", force: :cascade do |t|
    t.string   "title",                  null: false
    t.string   "location",               null: false
    t.integer  "total_cost", default: 0
    t.date     "date",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "display_name",   null: false
    t.string   "description"
    t.integer  "initial_budget", null: false
    t.float    "spent_budget"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "members", ["display_name"], name: "index_members_on_display_name", unique: true

end
