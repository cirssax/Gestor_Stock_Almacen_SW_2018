class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :id_producto
      t.integer :cantidad
    end
  end
end
