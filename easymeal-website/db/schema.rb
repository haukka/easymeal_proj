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

ActiveRecord::Schema.define(version: 20150119134502) do

  create_table "aliments", force: true do |t|
    t.string   "name"
    t.float    "calories"
    t.float    "sugar"
    t.float    "protein"
    t.float    "cholesterol"
    t.float    "fiber"
    t.float    "iron"
    t.float    "magnesium"
    t.float    "vitaminB1"
    t.float    "vitaminC"
    t.float    "vitaminD"
    t.float    "vitaminE"
    t.boolean  "isQuantifiable"
    t.float    "quantity"
    t.float    "averagePrice"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "vitaminB2"
    t.float    "vitaminB3"
    t.float    "vitaminB5"
    t.float    "vitaminB6"
    t.float    "vitaminB9"
    t.float    "vitaminB12"
    t.integer  "ident"
  end

  create_table "aliments_categories", force: true do |t|
    t.integer "aliment_id"
    t.integer "category_id"
  end

  create_table "aliments_homes", id: false, force: true do |t|
    t.integer "aliment_id", null: false
    t.integer "home_id",    null: false
  end

  create_table "aliments_quantities", force: true do |t|
    t.integer "aliment_id"
    t.integer "recipe_id"
    t.integer "quantity"
    t.integer "shopping_list_id"
    t.integer "stock_id"
  end

  create_table "aliments_shopping_lists", force: true do |t|
    t.integer "aliments_id"
    t.integer "shopping_lists_id"
  end

  create_table "allergen_and_favorite_aliments", force: true do |t|
    t.integer  "user_id"
    t.integer  "aliment_id"
    t.boolean  "allergy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "favori"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ident"
  end

  create_table "diet_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "diet_types_users", id: false, force: true do |t|
    t.integer "diet_type_id", null: false
    t.integer "user_id",      null: false
  end

  create_table "diseases", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diseases_users", id: false, force: true do |t|
    t.integer "user_id",    null: false
    t.integer "disease_id", null: false
  end

  create_table "exceeds", force: true do |t|
    t.integer  "disease_id"
    t.integer  "aliment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homes", force: true do |t|
    t.string   "street"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "householder_id"
    t.string   "zipcode"
    t.string   "name"
  end

  create_table "homes_stores", id: false, force: true do |t|
    t.integer "home_id",  null: false
    t.integer "store_id", null: false
  end

  create_table "menu_schedules", force: true do |t|
    t.integer  "home_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meal"
    t.date     "date"
  end

  create_table "menu_schedules_recipes", id: false, force: true do |t|
    t.integer "menu_schedule_id", null: false
    t.integer "recipe_id",        null: false
  end

  create_table "menu_schedules_users", force: true do |t|
    t.integer "user_id"
    t.integer "menu_schedule_id"
  end

  create_table "moderates", force: true do |t|
    t.integer  "disease_id"
    t.integer  "aliment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proscribes", force: true do |t|
    t.integer  "disease_id"
    t.integer  "aliment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_categories_recipes", id: false, force: true do |t|
    t.integer "recipe_category_id", null: false
    t.integer "recipe_id",          null: false
  end

  create_table "recipes", force: true do |t|
    t.text     "text"
    t.integer  "time"
    t.integer  "difficulty"
    t.integer  "calories"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "recipe_day",         default: false
    t.string   "workflow_state"
    t.integer  "nb_servings",        default: 1
  end

  create_table "shopping_lists", force: true do |t|
    t.float    "totalPrice"
    t.integer  "home_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "stocks", force: true do |t|
    t.integer  "home_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "stores", force: true do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password"
    t.string   "gender"
    t.date     "birth"
    t.integer  "role"
    t.date     "lastConnexion"
    t.integer  "loginAttempts"
    t.date     "lock"
    t.boolean  "islock"
    t.string   "resetToken"
    t.boolean  "highCholesterol"
    t.boolean  "highBloodPressure"
    t.integer  "height"
    t.integer  "weight"
    t.integer  "desireWeight"
    t.integer  "idealWeight"
    t.integer  "home_id"
    t.integer  "weightPointId"
    t.integer  "dietTypeId"
    t.integer  "weightCurveId"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "isAdmin",                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weight_points", force: true do |t|
    t.integer  "user_id"
    t.integer  "weight"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weight_points", ["user_id"], name: "index_weight_points_on_user_id"

end
