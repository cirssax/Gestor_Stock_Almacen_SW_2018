class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :id_tipo
      t.integer :precio
      t.string :nombre_producto
      t.integer :stock

      t.timestamps
    end
  end
end
