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

ActiveRecord::Schema.define(version: 20161109165336) do

  create_table "pareceres", force: :cascade do |t|
    t.integer  "pagina"
    t.string   "texto"
    t.integer  "trabalho_id"
    t.integer  "professor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "pareceres", ["professor_id"], name: "index_pareceres_on_professor_id"
  add_index "pareceres", ["trabalho_id"], name: "index_pareceres_on_trabalho_id"

  create_table "periodos", force: :cascade do |t|
    t.datetime "inicio"
    t.datetime "termino"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trabalhos", force: :cascade do |t|
    t.string   "titulo"
    t.integer  "estudante_id"
    t.integer  "orientador_id"
    t.integer  "banca_1_id"
    t.integer  "banca_2_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "arquivo_file_name"
    t.string   "arquivo_content_type"
    t.integer  "arquivo_file_size"
    t.datetime "arquivo_updated_at"
    t.string   "estado"
    t.float    "nota_banca_1"
    t.float    "nota_banca_2"
    t.float    "nota_orientador"
  end

  add_index "trabalhos", ["banca_1_id"], name: "index_trabalhos_on_banca_1_id"
  add_index "trabalhos", ["banca_2_id"], name: "index_trabalhos_on_banca_2_id"
  add_index "trabalhos", ["estudante_id"], name: "index_trabalhos_on_estudante_id"
  add_index "trabalhos", ["orientador_id"], name: "index_trabalhos_on_orientador_id"

  create_table "usuarios", force: :cascade do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "ra"
    t.string   "password_digest"
    t.string   "type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "estado_acesso"
  end

end
