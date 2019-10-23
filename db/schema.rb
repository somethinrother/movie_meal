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

ActiveRecord::Schema.define(version: 2019_10_13_010845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cocktails", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cocktails_ingredients", id: false, force: :cascade do |t|
    t.bigint "cocktail_id"
    t.bigint "ingredient_id"
    t.index ["cocktail_id"], name: "index_cocktails_ingredients_on_cocktail_id"
    t.index ["ingredient_id"], name: "index_cocktails_ingredients_on_ingredient_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients_movies", id: false, force: :cascade do |t|
    t.bigint "ingredient_id"
    t.bigint "movie_id"
    t.index ["ingredient_id"], name: "index_ingredients_movies_on_ingredient_id"
    t.index ["movie_id"], name: "index_ingredients_movies_on_movie_id"
  end

  create_table "ingredients_recipes", id: false, force: :cascade do |t|
    t.bigint "ingredient_id"
    t.bigint "recipe_id"
    t.index ["ingredient_id"], name: "index_ingredients_recipes_on_ingredient_id"
    t.index ["recipe_id"], name: "index_ingredients_recipes_on_recipe_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "writers"
    t.integer "year"
    t.text "script"
    t.boolean "is_scraped"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies_ingredients_associations", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "ingredient_id"
    t.integer "mentions"
    t.decimal "mentions_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_movies_ingredients_associations_on_ingredient_id"
    t.index ["movie_id", "ingredient_id"], name: "mov_ing_ass", unique: true
    t.index ["movie_id"], name: "index_movies_ingredients_associations_on_movie_id"
  end

  create_table "movies_recipes", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "recipe_id"
    t.integer "mentions"
    t.string "ingredient_mentions", default: [], array: true
    t.decimal "mentions_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id", "recipe_id"], name: "index_movies_recipes_on_movie_id_and_recipe_id", unique: true
    t.index ["movie_id"], name: "index_movies_recipes_on_movie_id"
    t.index ["recipe_id"], name: "index_movies_recipes_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
