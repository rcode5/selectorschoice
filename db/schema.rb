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

ActiveRecord::Schema[8.1].define(version: 2025_10_01_060421) do
  create_table "taggings", force: :cascade do |t|
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tracks", force: :cascade do |t|
    t.string "author"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "display_title"
    t.string "filename"
    t.text "playlist"
    t.boolean "published"
    t.datetime "recorded_on", precision: nil
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.index ["slug"], name: "index_tracks_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "confirmation_token", limit: 128
    t.datetime "created_at", precision: nil
    t.string "email"
    t.string "encrypted_password", limit: 128
    t.string "remember_token", limit: 128
    t.string "salt", limit: 128
    t.datetime "updated_at", precision: nil
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  # Virtual tables defined in this database.
  # Note that virtual tables may not work with other database engines. Be careful if changing database.
  create_virtual_table "track_search", "fts5", ["title", "description", "tracklist", "tags", "track_id"]
  create_virtual_table "track_searches", "fts5", ["title", "description", "playlist", "tags", "track_id"]
end
