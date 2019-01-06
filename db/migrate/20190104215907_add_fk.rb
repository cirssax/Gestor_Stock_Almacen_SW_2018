class AddFk < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :carts, :products, column: :id_producto, primary_key: :id
    add_foreign_key :sales, :users, column: :id_usuario, primary_key: :id
    remove_column :sales, :id_carro, :integer
  end
end
