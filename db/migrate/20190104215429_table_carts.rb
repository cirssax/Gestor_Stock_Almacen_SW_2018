class TableCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :sales, foreign_key: true
      t.integer :id_producto
      t.integer :cantidad
    end
  end
end
