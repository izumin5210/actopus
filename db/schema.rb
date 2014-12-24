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

ActiveRecord::Schema.define(version: 20141223064227) do

  create_table "staffs", force: :cascade do |t|
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
  end

  add_index "staffs", ["email"], name: "index_staffs_on_email", unique: true
  add_index "staffs", ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true

  create_table "courses", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "abbreviation_name", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "courses", ["abbreviation_name"], name: "index_courses_on_abbreviation_name", unique: true
  add_index "courses", ["name"], name: "index_courses_on_name", unique: true

  create_table "departments", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "abbreviation_name", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "departments", ["abbreviation_name"], name: "index_departments_on_abbreviation_name", unique: true
  add_index "departments", ["name"], name: "index_departments_on_name", unique: true

  create_table "held_lectures", force: :cascade do |t|
    t.integer  "lecture_id", null: false
    t.integer  "period_id",  null: false
    t.integer  "wday",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "held_lectures", ["lecture_id", "period_id", "wday"], name: "index_held_lectures_on_lecture_id_and_period_id_and_wday", unique: true

  create_table "lecturers", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "department_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string   "name",                             null: false
    t.integer  "grade",                            null: false
    t.boolean  "overseas_student", default: false
    t.integer  "department_id",                    null: false
    t.integer  "course_id"
    t.integer  "term_id",                          null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "periods", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "begin_at",   null: false
    t.string   "end_at",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "periods", ["begin_at", "end_at"], name: "index_periods_on_begin_at_and_end_at", unique: true
  add_index "periods", ["name"], name: "index_periods_on_name", unique: true

  create_table "teaching_lectures", force: :cascade do |t|
    t.integer  "lecture_id",  null: false
    t.integer  "lecturer_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "teaching_lectures", ["lecture_id", "lecturer_id"], name: "index_teaching_lectures_on_lecture_id_and_lecturer_id", unique: true

  create_table "terms", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "xml_filename", null: false
    t.date     "begin_at",     null: false
    t.date     "end_at",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "terms", ["begin_at", "end_at"], name: "index_terms_on_begin_at_and_end_at", unique: true
  add_index "terms", ["xml_filename"], name: "index_terms_on_xml_filename", unique: true

end
