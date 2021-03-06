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

ActiveRecord::Schema.define(version: 20140614205019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "admin_users", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 100, default: "", null: false
    t.string   "hashed_password", limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        limit: 25
  end

  add_index "admin_users", ["username"], :name => "index_admin_users_on_username"

  create_table "authentications", force: true do |t|
    t.integer  "usuari_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], :name => "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], :name => "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], :name => "index_badges_sashes_on_sash_id"

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

  create_table "favorita", force: true do |t|
    t.integer  "usuari_id"
    t.integer  "ruta_turistica_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorits", force: true do |t|
    t.integer  "pdi_id"
    t.integer  "usuari_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "pais", force: true do |t|
    t.string   "nom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pais_residencia", force: true do |t|
    t.integer  "pais_id"
    t.integer  "usuari_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pdis", force: true do |t|
    t.float    "punts"
    t.string   "nom"
    t.text     "horari"
    t.text     "fotos_petites"
    t.text     "fotos_grans"
    t.string   "telefon"
    t.string   "web"
    t.decimal  "preu_aprox"
    t.integer  "nivell_preu"
    t.string   "icone"
    t.string   "type"
    t.integer  "usuari_id"
    t.integer  "usuari_modificador_id"
    t.string   "adreca"
    t.string   "codi_postal"
    t.string   "localitat"
    t.string   "pais"
    t.string   "coord_lat"
    t.string   "coord_lng"
    t.text     "place_reference"
    t.spatial  "lonlat",                  limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer  "forquilles"
    t.integer  "classe_restaurant_id"
    t.integer  "classe_botiga_id"
    t.integer  "classe_museu_id"
    t.integer  "classe_entreteniment_id"
    t.integer  "estrelles"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "lat",                     limit: {:srid=>0, :type=>"point"}
    t.spatial  "lng",                     limit: {:srid=>0, :type=>"point"}
    t.spatial  "boundary",                limit: {:srid=>2285, :type=>"polygon"}
  end

  add_index "pdis", ["lonlat"], :name => "index_pdis_on_lonlat", :spatial => true

  create_table "pdis_rutaturisticas", force: true do |t|
    t.integer  "pdi_id"
    t.integer  "ruta_turistica_id"
    t.integer  "ordre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preguntas", force: true do |t|
    t.text     "text"
    t.integer  "questionari_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questionaris", force: true do |t|
    t.integer  "ruta_turistica_id"
    t.integer  "usuari_id"
    t.float    "param_reputacio"
    t.boolean  "param_pais_naixament",  default: false
    t.boolean  "param_pais_residencia", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "respostas", force: true do |t|
    t.text     "text"
    t.boolean  "correcta"
    t.integer  "pregunta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ruta_turisticas", force: true do |t|
    t.string   "nom"
    t.string   "temps"
    t.float    "punts"
    t.integer  "usuari_id"
    t.integer  "usuari_modificador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sashes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuari_questionaris", force: true do |t|
    t.integer  "usuari_id"
    t.integer  "questionari_id"
    t.float    "nota_treta"
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
    t.float    "punts"
    t.string   "coord_lat_browser"
    t.string   "coord_lng_browser"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sash_id"
    t.integer  "level",                        default: 0
    t.integer  "pais_id"
    t.integer  "authentication_id"
  end

  create_table "valoracios", force: true do |t|
    t.string   "titol"
    t.text     "opinio"
    t.integer  "punts"
    t.integer  "usuari_id"
    t.integer  "ruta_turistica_id"
    t.integer  "pdi_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
