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

ActiveRecord::Schema.define(version: 20150217104054) do

  create_table "academic_terms", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "xml_filename", null: false
    t.date     "started_on",   null: false
    t.date     "ended_on",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "academic_terms", ["ended_on"], name: "index_academic_terms_on_ended_on"
  add_index "academic_terms", ["started_on", "ended_on"], name: "index_academic_terms_on_started_on_and_ended_on", unique: true
  add_index "academic_terms", ["started_on"], name: "index_academic_terms_on_started_on"
  add_index "academic_terms", ["xml_filename"], name: "index_academic_terms_on_xml_filename", unique: true

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

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "klasses", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "department_id", null: false
    t.integer  "course_id"
    t.integer  "grade",         null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "category"
    t.string   "slug"
  end

  add_index "klasses", ["category"], name: "index_klasses_on_category"
  add_index "klasses", ["course_id"], name: "index_klasses_on_course_id"
  add_index "klasses", ["department_id", "course_id", "grade"], name: "index_klasses_on_department_id_and_course_id_and_grade", unique: true
  add_index "klasses", ["department_id"], name: "index_klasses_on_department_id"
  add_index "klasses", ["grade"], name: "index_klasses_on_grade"
  add_index "klasses", ["name"], name: "index_klasses_on_name", unique: true
  add_index "klasses", ["slug"], name: "index_klasses_on_slug", unique: true

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

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true

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
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "category"
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
