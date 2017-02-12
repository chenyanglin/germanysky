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

ActiveRecord::Schema.define(version: 20170208071730) do

  create_table "account_levels", force: :cascade do |t|
    t.string   "level_name",  limit: 255
    t.integer  "score",       limit: 4
    t.integer  "order_price", limit: 4
    t.integer  "discount",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "account_name",     limit: 255
    t.string   "password_digest",  limit: 255
    t.string   "name",             limit: 255
    t.string   "sex",              limit: 255
    t.string   "birthday",         limit: 255
    t.string   "email",            limit: 255
    t.string   "email_backup",     limit: 255
    t.string   "phone1",           limit: 255
    t.string   "phone2",           limit: 255
    t.string   "address",          limit: 255
    t.integer  "role",             limit: 4,   default: 2, null: false
    t.string   "account_level_id", limit: 255
    t.integer  "score",            limit: 4,   default: 0
    t.integer  "point",            limit: 4,   default: 0
    t.string   "deleted",          limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "googleid",         limit: 255
  end

  create_table "brandimages", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "phourl",              limit: 255
    t.string   "brand_id",            limit: 255
    t.string   "upload_file_name",    limit: 255
    t.string   "upload_content_type", limit: 255
    t.integer  "upload_file_size",    limit: 4
    t.datetime "upload_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "brands", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "briefdescription",  limit: 255
    t.string   "detaildescription", limit: 255
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "price",       limit: 4
    t.boolean  "available"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "manager_accounts", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 255
    t.string   "phone",           limit: 255
    t.string   "role",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "account_id",   limit: 255
    t.string   "account_name", limit: 255
    t.string   "title",        limit: 255
    t.string   "content",      limit: 255
    t.integer  "status",       limit: 4,   default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "newsboards", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "subtitle",   limit: 255
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "newsletter_emails", force: :cascade do |t|
    t.string   "email",        limit: 255
    t.string   "account_id",   limit: 255
    t.string   "account_name", limit: 255
    t.string   "name",         limit: 255
    t.integer  "status",       limit: 4,   default: 1, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "newsletter_emails", ["email"], name: "email_UNIQUE", unique: true, using: :btree

  create_table "newsletters", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.string   "content",    limit: 255
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "offer_images", force: :cascade do |t|
    t.string   "specialoffer_id",     limit: 255
    t.string   "phourl",              limit: 255
    t.string   "name",                limit: 255
    t.string   "upload_file_name",    limit: 255
    t.string   "upload_content_type", limit: 255
    t.integer  "upload_file_size",    limit: 4
    t.datetime "upload_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "order_messages", force: :cascade do |t|
    t.string   "order_id",     limit: 255
    t.string   "account_id",   limit: 255
    t.string   "content",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "reply",        limit: 255
    t.integer  "status",       limit: 4
    t.string   "account_name", limit: 255
  end

  create_table "order_products", force: :cascade do |t|
    t.string   "order_id",     limit: 255
    t.string   "product_id",   limit: 255
    t.string   "product_name", limit: 255
    t.integer  "single_price", limit: 4
    t.integer  "sum_price",    limit: 4
    t.integer  "sum",          limit: 4
    t.string   "option_name",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "ordernumber",      limit: 255
    t.string   "account_id",       limit: 255,             null: false
    t.string   "account_name",     limit: 255
    t.integer  "total_price",      limit: 4,               null: false
    t.string   "delivery_id",      limit: 255,             null: false
    t.string   "delivery",         limit: 255
    t.integer  "delivery_price",   limit: 4,               null: false
    t.boolean  "cash_on_delivery"
    t.string   "payment_id",       limit: 255,             null: false
    t.string   "payment",          limit: 255
    t.integer  "payment_price",    limit: 4,               null: false
    t.string   "receiver_name",    limit: 255
    t.string   "receiver_address", limit: 255
    t.string   "receiver_phone",   limit: 255
    t.integer  "pay_status",       limit: 4,   default: 1
    t.integer  "delivery_status",  limit: 4,   default: 1
    t.string   "note",             limit: 255
    t.string   "use_point",        limit: 255
    t.string   "lastfivepay",      limit: 255
    t.integer  "paidprice",        limit: 4
    t.date     "pay_date"
    t.date     "send_date"
    t.date     "change_date"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "get_point",        limit: 4
  end

  add_index "orders", ["ordernumber"], name: "ordernumber_UNIQUE", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "dayline",     limit: 4
    t.integer  "price",       limit: 4,   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "pays", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.boolean  "available"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "product_deliveryships", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "delivery_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "product_deliveryships", ["product_id", "delivery_id"], name: "index_product_deliveryships_on_product_id_and_delivery_id", unique: true, using: :btree

  create_table "product_messages", force: :cascade do |t|
    t.string   "account_id",   limit: 255
    t.string   "account_name", limit: 255
    t.string   "product_id",   limit: 255
    t.string   "content",      limit: 255
    t.string   "reply",        limit: 255
    t.integer  "status",       limit: 4,   default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "product_options", force: :cascade do |t|
    t.string   "product_id", limit: 255
    t.string   "option1",    limit: 255
    t.string   "option2",    limit: 255
    t.string   "option3",    limit: 255
    t.integer  "price",      limit: 4
    t.integer  "surplus",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "product_paymentships", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "payment_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "product_paymentships", ["product_id", "payment_id"], name: "index_product_paymentships_on_product_id_and_payment_id", unique: true, using: :btree

  create_table "product_registers", force: :cascade do |t|
    t.string   "email",             limit: 255
    t.string   "account_id",        limit: 255
    t.string   "account_name",      limit: 255
    t.string   "product_id",        limit: 255
    t.string   "product_option_id", limit: 255
    t.integer  "quantity",          limit: 4
    t.integer  "sendemail",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "product_specialofferships", force: :cascade do |t|
    t.integer  "product_id",        limit: 4
    t.integer  "product_option_id", limit: 4
    t.integer  "specialoffer_id",   limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "product_specialofferships", ["product_id", "product_option_id", "specialoffer_id"], name: "offer_index", unique: true, using: :btree

  create_table "product_typeships", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "type_one_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "product_typeships", ["product_id", "type_one_id"], name: "index_product_typeships_on_product_id_and_type_id", unique: true, using: :btree

  create_table "productimages", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "upload_file_name",    limit: 255
    t.string   "upload_content_type", limit: 255
    t.integer  "upload_file_size",    limit: 4
    t.datetime "upload_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "product_id",          limit: 255
    t.string   "phourl",              limit: 255
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "name",              limit: 255
    t.string   "briefdescription",  limit: 255
    t.string   "detaildescription", limit: 255
    t.integer  "price",             limit: 4
    t.integer  "surplus",           limit: 4
    t.string   "phourl",            limit: 255
    t.boolean  "on_store"
    t.boolean  "available"
    t.string   "type_one_id",       limit: 255
    t.string   "type_two_id",       limit: 255
    t.string   "type_three_id",     limit: 255
    t.string   "producttype_id",    limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.text     "content",           limit: 65535
    t.string   "brand_id",          limit: 255
    t.integer  "point",             limit: 4,     default: 0
  end

  create_table "producttypes", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "redactor_assets", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], name: "idx_redactor_assetable", using: :btree
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_redactor_assetable_type", using: :btree

  create_table "replies", force: :cascade do |t|
    t.string   "message_id",   limit: 255
    t.string   "account_id",   limit: 255
    t.string   "account_name", limit: 255
    t.string   "content",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "salecart_products", force: :cascade do |t|
    t.string   "product_id",    limit: 255
    t.string   "option_id",     limit: 255
    t.string   "salecart_id",   limit: 255
    t.integer  "sum",           limit: 4
    t.integer  "originalprice", limit: 4
    t.integer  "sellprice",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "get_point",     limit: 4
  end

  create_table "salecarts", force: :cascade do |t|
    t.string   "account_id",      limit: 255
    t.string   "specialoffer_id", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "get_point",       limit: 4
  end

  create_table "shoppingcarts", force: :cascade do |t|
    t.string   "account_id",    limit: 255
    t.string   "product_id",    limit: 255
    t.string   "option_id",     limit: 255
    t.integer  "sum",           limit: 4
    t.integer  "originalprice", limit: 4
    t.integer  "sellprice",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "get_point",     limit: 4
  end

  add_index "shoppingcarts", ["account_id", "product_id", "option_id"], name: "index_account_product", unique: true, using: :btree

  create_table "specialoffers", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "offertype",    limit: 255
    t.integer  "productcount", limit: 4
    t.integer  "saleprice",    limit: 4
    t.integer  "discount",     limit: 4
    t.string   "phourl",       limit: 255
    t.string   "status",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "type_ones", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "photourl",    limit: 255
    t.string   "tag",         limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "type_threes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "photourl",    limit: 255
    t.string   "tag",         limit: 255
    t.string   "type_two_id", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "type_twos", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "photourl",    limit: 255
    t.string   "tag",         limit: 255
    t.string   "type_one_id", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "userlevels", force: :cascade do |t|
    t.string   "level_name",   limit: 255
    t.integer  "point_min",    limit: 4
    t.integer  "point_max",    limit: 4
    t.integer  "discountrate", limit: 4
    t.integer  "level",        limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
