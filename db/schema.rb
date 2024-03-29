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

ActiveRecord::Schema.define(version: 20140512202133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
  end

  create_table "campaign_targets", force: true do |t|
    t.integer  "campaign_id"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "script"
    t.string   "twitter_share_text"
    t.string   "twilio_number"
  end

  create_table "campaigns", force: true do |t|
    t.integer  "organization_id",                 null: false
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",          default: false
    t.string   "vanity_string"
    t.boolean  "fcc"
  end

  create_table "email_subscribers", force: true do |t|
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "organization_id", null: false
    t.integer  "member_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vanity_string"
    t.string   "host_url"
  end

  create_table "phone_call_feedbacks", force: true do |t|
    t.integer  "phone_call_id"
    t.string   "email_address"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_calls", force: true do |t|
    t.text     "twilio_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "from_number"
    t.string   "sid"
    t.string   "twilio_client_from"
    t.string   "twilio_client_to"
    t.string   "status"
    t.string   "direction"
    t.string   "api_version"
    t.integer  "call_duration"
    t.integer  "minutes_billed"
    t.string   "forwarded_from"
    t.string   "from_city"
    t.string   "from_state"
    t.string   "from_zip"
    t.string   "from_country"
    t.string   "to_city"
    t.string   "to_state"
    t.string   "to_zip"
    t.string   "to_country"
    t.integer  "campaign_target_id"
  end

  create_table "pictures", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
    t.string   "s3_key"
  end

  create_table "targets", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
