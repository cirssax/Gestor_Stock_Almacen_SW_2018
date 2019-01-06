class TableSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :id_usuario
      t.integer :id_carro
      t.datetime :fecha_venta

      t.timestamps
    end
  end
end
