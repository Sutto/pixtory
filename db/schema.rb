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

ActiveRecord::Schema.define(version: 20130601074500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "moments", force: true do |t|
    t.string   "image",                                                                                        null: false
    t.integer  "width"
    t.integer  "height"
    t.text     "caption",                                                                                      null: false
    t.text     "location",                                                                                     null: false
    t.date     "captured_at"
    t.boolean  "approximate_date",                                                             default: false
    t.text     "source_url"
    t.string   "source_name"
    t.string   "license"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_key"
    t.string   "external_identifier"
    t.spatial  "coordinates",         limit: {:srid=>4326, :type=>"point", :geographic=>true},                 null: false
  end

  add_index "moments", ["coordinates"], :name => "index_moments_on_coordinates", :spatial => true
  add_index "moments", ["external_key", "external_identifier"], :name => "index_moments_on_external_key_and_external_identifier", :unique => true

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "avatar"
    t.string   "location"
    t.string   "push_token",           null: false
    t.string   "authentication_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["authentication_token"], :name => "index_people_on_authentication_token", :unique => true
  add_index "people", ["push_token"], :name => "index_people_on_push_token", :unique => true

end
