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

ActiveRecord::Schema.define(version: 20150813181320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disciplines", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "semesters", force: :cascade do |t|
    t.integer  "name",           default: 1
    t.text     "characteristic", default: ""
    t.float    "avg_mark"
    t.integer  "student_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "semesters", ["avg_mark"], name: "index_semesters_on_avg_mark", using: :btree
  add_index "semesters", ["characteristic"], name: "index_semesters_on_characteristic", using: :btree
  add_index "semesters", ["name"], name: "index_semesters_on_name", using: :btree
  add_index "semesters", ["student_id"], name: "index_semesters_on_student_id", using: :btree

  create_table "semesters_disciplines", force: :cascade do |t|
    t.integer  "semester_id"
    t.integer  "discipline_id"
    t.integer  "mark"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "semesters_disciplines", ["semester_id", "discipline_id"], name: "index_semesters_disciplines_on_semester_id_and_discipline_id", unique: true, using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "study_group"
    t.date     "birthday"
    t.string   "email"
    t.string   "ip"
    t.datetime "registered_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "students", ["first_name", "last_name"], name: "index_students_on_first_name_and_last_name", using: :btree
  add_index "students", ["ip"], name: "index_students_on_ip", using: :btree
  add_index "students", ["study_group"], name: "index_students_on_study_group", using: :btree

  add_foreign_key "semesters", "students"
  add_foreign_key "semesters_disciplines", "disciplines"
  add_foreign_key "semesters_disciplines", "semesters"
end
