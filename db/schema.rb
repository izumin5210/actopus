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

ActiveRecord::Schema.define(version: 20150114005849) do

  create_table "courses", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "abbreviation_name", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "courses", ["abbreviation_name"], name: "index_courses_on_abbreviation_name", unique: true
  add_index "courses", ["name"], name: "index_courses_on_name", unique: true

  create_table "date_periods", force: :cascade do |t|
    t.integer  "period_id"
    t.date     "taken_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "abbreviation_name", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "departments", ["abbreviation_name"], name: "index_departments_on_abbreviation_name", unique: true
  add_index "departments", ["name"], name: "index_departments_on_name", unique: true

  create_table "klasses", force: :cascade do |t|
    t.string   "name",                      null: false
    t.integer  "department_id",             null: false
    t.integer  "course_id"
    t.integer  "grade",                     null: false
    t.integer  "category",      default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "klasses", ["category"], name: "index_klasses_on_category"
  add_index "klasses", ["course_id"], name: "index_klasses_on_course_id"
  add_index "klasses", ["department_id", "course_id", "grade"], name: "index_klasses_on_department_id_and_course_id_and_grade", unique: true
  add_index "klasses", ["department_id"], name: "index_klasses_on_department_id"
  add_index "klasses", ["grade"], name: "index_klasses_on_grade"
  add_index "klasses", ["name"], name: "index_klasses_on_name", unique: true

  create_table "lecturers", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string   "name",           null: false
    t.integer  "term_id",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "klass_id"
    t.integer  "special_target"
    t.string   "code"
  end

  add_index "lectures", ["code"], name: "index_lectures_on_code"
  add_index "lectures", ["klass_id"], name: "index_lectures_on_klass_id"
  add_index "lectures", ["term_id"], name: "index_lectures_on_term_id"

  create_table "lecturings", force: :cascade do |t|
    t.integer  "lecture_id",  null: false
    t.integer  "lecturer_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lecturings", ["lecture_id", "lecturer_id"], name: "index_lecturings_on_lecture_id_and_lecturer_id", unique: true

  create_table "periods", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "start_time", null: false
    t.string   "end_time",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "periods", ["end_time"], name: "index_periods_on_end_time"
  add_index "periods", ["name"], name: "index_periods_on_name", unique: true
  add_index "periods", ["start_time", "end_time"], name: "index_periods_on_start_time_and_end_time", unique: true
  add_index "periods", ["start_time"], name: "index_periods_on_start_time"

  create_table "reschedulings", force: :cascade do |t|
    t.integer  "lecture_id"
    t.integer  "before_date_period_id"
    t.integer  "after_date_period_id"
    t.string   "category"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "schedulings", force: :cascade do |t|
    t.integer  "lecture_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "wday_period_id", null: false
  end

  add_index "schedulings", ["lecture_id", "wday_period_id"], name: "index_schedulings_on_lecture_id_and_wday_period_id", unique: true

  create_table "staffs", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
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
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "staffs", ["email"], name: "index_staffs_on_email", unique: true
  add_index "staffs", ["invitation_token"], name: "index_staffs_on_invitation_token", unique: true
  add_index "staffs", ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true

  create_table "terms", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "xml_filename", null: false
    t.date     "started_on",   null: false
    t.date     "ended_on",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "terms", ["ended_on"], name: "index_terms_on_ended_on"
  add_index "terms", ["started_on", "ended_on"], name: "index_terms_on_started_on_and_ended_on", unique: true
  add_index "terms", ["started_on"], name: "index_terms_on_started_on"
  add_index "terms", ["xml_filename"], name: "index_terms_on_xml_filename", unique: true

  create_table "wday_periods", force: :cascade do |t|
    t.integer  "period_id",  null: false
    t.integer  "wday",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wday_periods", ["period_id", "wday"], name: "index_wday_periods_on_period_id_and_wday", unique: true
  add_index "wday_periods", ["period_id"], name: "index_wday_periods_on_period_id"
  add_index "wday_periods", ["wday"], name: "index_wday_periods_on_wday"

end
