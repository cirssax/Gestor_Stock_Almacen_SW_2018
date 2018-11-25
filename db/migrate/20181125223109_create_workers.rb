class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers do |t|
      t.integer :id_rol
      t.integer :estado
      t.string :nombre_trabajador
      t.string :apellidos_trabajador
      t.integer :rut
      t.string :dv
      t.integer :fono
      t.string :domicilio

      t.timestamps
    end
  end
end
