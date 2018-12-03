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

ActiveRecord::Schema.define(version: 2018_12_02_234454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.integer "id_tipo"
    t.integer "precio"
    t.string "nombre_producto"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "descrip_rol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer "id_producto"
    t.integer "id_trabajador"
    t.datetime "fecha_venta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "descrip_estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "descrip_tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workers", force: :cascade do |t|
    t.integer "id_rol"
    t.string "nombre_trabajador"
    t.string "apellidos_trabajador"
    t.integer "rut"
    t.string "dv"
    t.integer "fono"
    t.string "domicilio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "id_estado"
  end

  add_foreign_key "products", "types", column: "id_tipo"
  add_foreign_key "sales", "products", column: "id_producto"
  add_foreign_key "sales", "workers", column: "id_trabajador"
  add_foreign_key "workers", "roles", column: "id_rol"
  add_foreign_key "workers", "states", column: "id_estado"
end
