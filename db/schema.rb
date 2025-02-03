# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_03_101659) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bean_comment_votes", force: :cascade do |t|
    t.boolean "vote"
    t.bigint "bean_comment_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bean_comment_id"], name: "index_bean_comment_votes_on_bean_comment_id"
    t.index ["user_id"], name: "index_bean_comment_votes_on_user_id"
  end

  create_table "bean_comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "user_id", null: false
    t.bigint "bean_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bean_id"], name: "index_bean_comments_on_bean_id"
    t.index ["user_id"], name: "index_bean_comments_on_user_id"
  end

  create_table "bean_reviews", force: :cascade do |t|
    t.integer "rating"
    t.bigint "user_id", null: false
    t.bigint "bean_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bean_id"], name: "index_bean_reviews_on_bean_id"
    t.index ["user_id"], name: "index_bean_reviews_on_user_id"
  end

  create_table "beans", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "roast_level"
    t.string "brewing_method"
    t.bigint "user_id", null: false
    t.bigint "roastery_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "origin"
    t.string "flavour"
    t.index ["roastery_id"], name: "index_beans_on_roastery_id"
    t.index ["user_id"], name: "index_beans_on_user_id"
  end

  create_table "favourite_beans", force: :cascade do |t|
    t.bigint "bean_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bean_id"], name: "index_favourite_beans_on_bean_id"
    t.index ["user_id"], name: "index_favourite_beans_on_user_id"
  end

  create_table "favourite_roasteries", force: :cascade do |t|
    t.bigint "roastery_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roastery_id"], name: "index_favourite_roasteries_on_roastery_id"
    t.index ["user_id"], name: "index_favourite_roasteries_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.string "location_type"
    t.bigint "roastery_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["roastery_id"], name: "index_locations_on_roastery_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.text "instructions"
    t.bigint "bean_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bean_id"], name: "index_recipes_on_bean_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "roasteries", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "address"
    t.string "roastery_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_roasteries_on_user_id"
  end

  create_table "roastery_comment_votes", force: :cascade do |t|
    t.boolean "vote"
    t.bigint "user_id", null: false
    t.bigint "roastery_comment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roastery_comment_id"], name: "index_roastery_comment_votes_on_roastery_comment_id"
    t.index ["user_id"], name: "index_roastery_comment_votes_on_user_id"
  end

  create_table "roastery_comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "roastery_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roastery_id"], name: "index_roastery_comments_on_roastery_id"
    t.index ["user_id"], name: "index_roastery_comments_on_user_id"
  end

  create_table "roastery_reviews", force: :cascade do |t|
    t.integer "rating"
    t.bigint "roastery_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roastery_id"], name: "index_roastery_reviews_on_roastery_id"
    t.index ["user_id"], name: "index_roastery_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bean_comment_votes", "bean_comments"
  add_foreign_key "bean_comment_votes", "users"
  add_foreign_key "bean_comments", "beans"
  add_foreign_key "bean_comments", "users"
  add_foreign_key "bean_reviews", "beans"
  add_foreign_key "bean_reviews", "users"
  add_foreign_key "beans", "roasteries"
  add_foreign_key "beans", "users"
  add_foreign_key "favourite_beans", "beans"
  add_foreign_key "favourite_beans", "users"
  add_foreign_key "favourite_roasteries", "roasteries"
  add_foreign_key "favourite_roasteries", "users"
  add_foreign_key "locations", "roasteries"
  add_foreign_key "recipes", "beans"
  add_foreign_key "recipes", "users"
  add_foreign_key "roasteries", "users"
  add_foreign_key "roastery_comment_votes", "roastery_comments"
  add_foreign_key "roastery_comment_votes", "users"
  add_foreign_key "roastery_comments", "roasteries"
  add_foreign_key "roastery_comments", "users"
  add_foreign_key "roastery_reviews", "roasteries"
  add_foreign_key "roastery_reviews", "users"
end
