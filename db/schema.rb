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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130401134244) do

  create_table "consumers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contexts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delivery_addresses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "delivery_service_id"
    t.integer  "consumer_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "delivery_addresses", ["consumer_id"], :name => "index_delivery_addresses_on_consumer_id"
  add_index "delivery_addresses", ["delivery_service_id"], :name => "index_delivery_addresses_on_delivery_service_id"

  create_table "delivery_service_properties", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "delivery_service_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "delivery_service_properties", ["delivery_service_id"], :name => "index_delivery_service_properties_on_delivery_service_id"

  create_table "delivery_services", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "escalation_levels", :force => true do |t|
    t.string   "name"
    t.integer  "context_id"
    t.integer  "level"
    t.integer  "when"
    t.boolean  "sequential_notification"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "escalation_levels", ["context_id"], :name => "index_escalation_levels_on_context_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "scheduled_escalations", :force => true do |t|
    t.integer  "subscription_id"
    t.datetime "duedate"
    t.string   "external_reference_id"
    t.string   "status"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "scheduled_escalations", ["subscription_id"], :name => "index_scheduled_escalations_on_subscription_id"

  create_table "subscriptions", :force => true do |t|
    t.string   "name"
    t.integer  "escalation_level_id"
    t.integer  "delivery_address_id"
    t.integer  "consumer_sequence"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "subscriptions", ["delivery_address_id"], :name => "index_subscriptions_on_delivery_address_id"
  add_index "subscriptions", ["escalation_level_id"], :name => "index_subscriptions_on_escalation_level_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "authentication_token"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "users_roles", :id => true, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
