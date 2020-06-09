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

ActiveRecord::Schema.define(version: 2020_06_08_232212) do

  create_table "food_preferences", force: :cascade do |t|
    t.integer "tiger_id"
    t.integer "food_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.integer "price"
  end

  create_table "tigers", force: :cascade do |t|
    t.string "name"
    t.string "breed"
    t.integer "price"
    t.string "breed"
    t.integer "health"
    t.datetime "time_born"
    t.boolean "alive?", default: true
    t.boolean "bought?", default: false
    t.integer "zoo_id"
  end

  create_table "zoofoods", force: :cascade do |t|
    t.integer "zoo_id"
    t.integer "food_id"
  end

  create_table "zookeepers", force: :cascade do |t|
    t.string "name"
    t.boolean "alive?"
  end

  create_table "zoos", force: :cascade do |t|
    t.string "name"
    t.integer "money"
    t.integer "zookeeper_id"
  end

end
