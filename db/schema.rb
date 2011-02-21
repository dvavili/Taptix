# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110221164821) do

  create_table "event_registrations", :force => true do |t|
    t.integer   "event_id"
    t.integer   "application_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "confirmation"
    t.integer   "attended"
  end

  create_table "events", :force => true do |t|
    t.string   "web_page_link"
    t.string   "image_link"
    t.string   "video_link"
    t.datetime "date"
    t.string   "contact"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_hits"
    t.integer  "user_id"
    t.string   "address"
    t.decimal  "lng"
    t.decimal  "lat"
    t.string   "title"
    t.text     "description",    :limit => 255
    t.string   "category"
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "phone"
    t.string    "address"
    t.string    "contract"
    t.string    "email",                               :default => "", :null => false
    t.string    "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string    "password_salt",                       :default => "", :null => false
    t.string    "reset_password_token"
    t.string    "remember_token"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
