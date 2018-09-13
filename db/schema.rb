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

ActiveRecord::Schema.define(version: 2018_09_13_131005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_token_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "claims", force: :cascade do |t|
    t.integer "policy_id"
    t.integer "amount"
    t.integer "status", default: 0
    t.datetime "requirements_accepted_at"
    t.datetime "on_process_at"
    t.datetime "success_or_rejected_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.integer "insurance_type"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "policy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "policies", force: :cascade do |t|
    t.string "policy_number"
    t.integer "user_id"
    t.string "insured_item"
    t.string "item_description"
    t.integer "insurance_type"
    t.integer "premium_per_month"
    t.integer "payment_due_date"
    t.integer "limit_per_year"
    t.integer "balance"
    t.integer "deposit"
    t.string "document_url"
    t.integer "status", default: 0
    t.date "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["policy_number"], name: "index_policies_on_policy_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "id_card_number"
    t.integer "gender"
    t.string "address"
    t.string "phone_number"
    t.string "place_of_birth"
    t.date "date_of_birth"
    t.string "reset_password_token"
    t.datetime "reset_password_token_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "city"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id_card_number"], name: "index_users_on_id_card_number", unique: true
  end

end
