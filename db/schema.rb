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

ActiveRecord::Schema.define(version: 20140506212849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 100, default: "", null: false
    t.string   "hashed_password", limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        limit: 25
  end

  add_index "admin_users", ["username"], name: "index_admin_users_on_username", using: :btree

  create_table "ciutats", force: true do |t|
    t.string   "nom"
    t.string   "moneda"
    t.integer  "pais_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classe_botigas", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classe_entreteniments", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classe_museus", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classe_restaurants", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "etiqueta", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "etiquetes_pdis", force: true do |t|
    t.integer  "etiqueta_id"
    t.integer  "pdi_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorits", force: true do |t|
    t.integer  "pdi_id"
    t.integer  "usuari_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pais", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pdis", force: true do |t|
    t.string   "nom"
    t.string   "observacions"
    t.string   "horari"
    t.string   "telefon"
    t.string   "web"
    t.decimal  "preu_aprox"
    t.integer  "nivell_preu"
    t.string   "type"
    t.integer  "usuari_id"
    t.integer  "usuari_modificador_id"
    t.string   "adreca"
    t.string   "codi_postal"
    t.string   "localitat"
    t.string   "pais"
    t.string   "coord_lat"
    t.string   "coord_lng"
    t.integer  "forquilles"
    t.integer  "classe_restaurant_id"
    t.integer  "classe_botiga_id"
    t.integer  "classe_museu_id"
    t.integer  "classe_entreteniment_id"
    t.integer  "estrelles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pdis_rutaturisticas", force: true do |t|
    t.integer  "pdi_id"
    t.integer  "ruta_turistica_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ruta_turisticas", force: true do |t|
    t.string   "nom"
    t.string   "temps"
    t.integer  "usuari_id"
    t.integer  "usuari_modificador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuaris", force: true do |t|
    t.string   "nom",               limit: 25
    t.string   "cognom",            limit: 25
    t.string   "nom_usuari",        limit: 50
    t.string   "email",             limit: 40
    t.string   "password_digest"
    t.string   "edat",              limit: 3
    t.string   "sexe",              limit: 10
    t.string   "ciutat_naixament",  limit: 25
    t.string   "pais_naixament",    limit: 25
    t.string   "ciutat_residencia", limit: 25
    t.string   "pais_residencia",   limit: 25
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
