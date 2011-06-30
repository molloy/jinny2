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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110629072825) do

  create_table "address_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.integer  "address_type_id", :null => false
    t.integer  "person_id",       :null => false
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_3"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_offerings", :force => true do |t|
    t.integer  "course_id",             :null => false
    t.integer  "year",                  :null => false
    t.integer  "term_type_id",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "instructor"
    t.string   "syllabus_content_type"
    t.string   "syllabus_file_name"
    t.integer  "syllabus_file_size"
    t.datetime "syllabus_updated_at"
  end

  create_table "course_taken_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_takens", :force => true do |t|
    t.integer  "person_id",              :null => false
    t.integer  "course_offering_id",     :null => false
    t.integer  "course_taken_status_id", :null => false
    t.integer  "grade_type_id",          :null => false
    t.text     "evaluation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "course_number"
    t.integer  "units"
    t.integer  "department_id"
  end

  create_table "degree_programs", :force => true do |t|
    t.string   "title"
    t.integer  "major_id"
    t.integer  "degree_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "degree_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "degrees", :force => true do |t|
    t.integer  "person_id",   :null => false
    t.integer  "major_id",    :null => false
    t.string   "institution"
    t.boolean  "earned"
    t.date     "earned_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_types", :force => true do |t|
    t.string   "letter_grade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "numeric_weight"
  end

  create_table "invoice_items", :force => true do |t|
    t.integer  "invoice_id",                                 :null => false
    t.string   "name",                                       :null => false
    t.string   "description"
    t.decimal  "unit_price",  :precision => 10, :scale => 0, :null => false
    t.integer  "quantity",                                   :null => false
    t.decimal  "discount",    :precision => 10, :scale => 0
    t.decimal  "total",       :precision => 10, :scale => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.string   "invoice_number",                                      :null => false
    t.integer  "bill_to",                                             :null => false
    t.string   "bill_to_address_1"
    t.string   "bill_to_address_2"
    t.string   "bill_to_address_3"
    t.string   "bill_to_city"
    t.string   "bill_to_province"
    t.string   "bill_to_postal_code"
    t.string   "bill_to_country"
    t.string   "remit_to"
    t.string   "remit_to_address_1"
    t.string   "remit_to_address_2"
    t.string   "remit_to_address_3"
    t.string   "remit_to_city"
    t.string   "remit_to_province"
    t.string   "remit_to_postal_code"
    t.string   "remit_to_country"
    t.date     "invoice_date"
    t.integer  "invoice_term"
    t.decimal  "invoice_amount",       :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bill_to_address"
  end

  create_table "majors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.integer  "person_type_id",                             :null => false
    t.string   "given_name"
    t.string   "middle_name"
    t.string   "surname"
    t.string   "native_given_name"
    t.string   "native_surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ssn"
    t.boolean  "international"
    t.boolean  "correspondence"
    t.date     "dob"
    t.string   "email"
    t.date     "date_enrolled"
    t.date     "date_graduated"
    t.string   "gender"
    t.string   "title"
    t.integer  "department_id"
    t.string   "picture_content_type"
    t.binary   "picture",                :limit => 16777215
    t.binary   "resume_cv",              :limit => 16777215
    t.string   "resume_cv_content_type"
    t.integer  "degree_program_id"
    t.boolean  "distance_learning"
  end

  add_index "people", ["email"], :name => "index_people_on_email"

  create_table "person_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", :force => true do |t|
    t.integer  "phone_type_id", :null => false
    t.integer  "person_id",     :null => false
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_types", :force => true do |t|
    t.integer  "order"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "person_id"
    t.string   "email",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.string   "current_login_ip"
    t.datetime "last_login_at"
    t.string   "last_login_ip"
    t.string   "given_name"
    t.string   "surname"
    t.integer  "person_type_id",     :default => 0, :null => false
  end

end
