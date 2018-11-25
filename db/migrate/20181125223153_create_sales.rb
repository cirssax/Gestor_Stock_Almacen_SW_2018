class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :id_producto
      t.integer :id_trabajador
      t.datetime :fecha_venta

      t.timestamps
    end
  end
end
