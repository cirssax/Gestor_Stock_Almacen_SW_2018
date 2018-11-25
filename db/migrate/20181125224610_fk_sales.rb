class FkSales < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :sales, :workers, column: :id_trabajador, primary_key: :id
    add_foreign_key :sales, :products, column: :id_producto, primary_key: :id
  end
end
