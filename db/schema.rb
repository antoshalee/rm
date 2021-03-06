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

ActiveRecord::Schema.define(:version => 20140204103053) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "album_items", :force => true do |t|
    t.string   "image"
    t.integer  "album_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  add_index "album_items", ["album_id"], :name => "index_album_items_on_album_id"

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "published_at"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "published_at"
    t.integer  "sidebar_id"
  end

  create_table "banners", :force => true do |t|
    t.string   "image"
    t.text     "text"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "url"
  end

  create_table "cards", :force => true do |t|
    t.string   "number"
    t.integer  "discount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.decimal  "balance"
  end

  add_index "cards", ["number"], :name => "index_cards_on_number", :unique => true

  create_table "catalog_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "catalog_inserts", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "catalog_inserts_items", :force => true do |t|
    t.integer "insert_id", :null => false
    t.integer "item_id",   :null => false
  end

  add_index "catalog_inserts_items", ["insert_id"], :name => "index_catalog_inserts_items_on_insert_id"
  add_index "catalog_inserts_items", ["item_id"], :name => "index_catalog_inserts_items_on_item_id"

  create_table "catalog_items", :force => true do |t|
    t.string   "article",     :null => false
    t.string   "metal",       :null => false
    t.string   "image"
    t.integer  "category_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "weight"
  end

  add_index "catalog_items", ["article"], :name => "index_catalog_items_on_article"
  add_index "catalog_items", ["category_id"], :name => "index_catalog_items_on_category_id"
  add_index "catalog_items", ["metal"], :name => "index_catalog_items_on_metal"

  create_table "catalog_items_metals", :force => true do |t|
    t.integer "metal_id", :null => false
    t.integer "item_id",  :null => false
  end

  add_index "catalog_items_metals", ["item_id"], :name => "index_catalog_items_metals_on_item_id"
  add_index "catalog_items_metals", ["metal_id"], :name => "index_catalog_items_metals_on_metal_id"

  create_table "catalog_metals", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "collection_items", :force => true do |t|
    t.string   "article"
    t.decimal  "weight"
    t.string   "image"
    t.integer  "collection_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.decimal  "price",         :precision => 8, :scale => 2
  end

  add_index "collection_items", ["collection_id"], :name => "index_collection_items_on_collection_id"

  create_table "collections", :force => true do |t|
    t.string   "title"
    t.string   "price"
    t.text     "description"
    t.integer  "position"
    t.string   "note"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "contact_groups", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "position",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "address"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "contact_group_id", :null => false
    t.text     "content",          :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "contacts", ["contact_group_id"], :name => "index_contacts_on_contact_group_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feedbacks", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "letters", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.string   "color"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "magazines", :force => true do |t|
    t.string   "url"
    t.string   "embedId"
    t.string   "documentId"
    t.text     "lead"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "offers", :force => true do |t|
    t.string   "title"
    t.date     "date_start"
    t.date     "date_finish"
    t.text     "lead"
    t.text     "content"
    t.string   "image"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "is_main",     :default => false
    t.boolean  "discount",    :default => false
    t.integer  "position"
    t.integer  "sidebar_id"
    t.string   "slide_image"
  end

  add_index "offers", ["is_main"], :name => "index_offers_on_is_main"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "template",   :default => "standard"
    t.integer  "sidebar_id"
    t.text     "submenu"
  end

  create_table "sidebar_items", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "page_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "sidebar_id"
  end

  add_index "sidebar_items", ["page_id"], :name => "index_sidebar_items_on_page_id"
  add_index "sidebar_items", ["sidebar_id"], :name => "index_sidebar_items_on_sidebar_id"

  create_table "sidebars", :force => true do |t|
    t.string   "kind"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.boolean  "display_on_articles_page", :default => false
    t.boolean  "display_on_offers_page",   :default => false
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.string   "address"
    t.string   "phone"
    t.string   "opening_hours"
    t.string   "image"
    t.string   "email"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "kind"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
  end

  add_index "subscriptions", ["confirmation_token"], :name => "index_subscriptions_on_confirmation_token"
  add_index "subscriptions", ["confirmed_at"], :name => "index_subscriptions_on_confirmed_at"

  create_table "suppliers", :force => true do |t|
    t.string   "title"
    t.string   "image"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "variables", :force => true do |t|
    t.string   "key"
    t.string   "label"
    t.text     "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "variables", ["key"], :name => "index_variables_on_key"

  create_table "wholesale_managers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
