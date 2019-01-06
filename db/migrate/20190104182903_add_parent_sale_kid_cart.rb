class AddParentSaleKidCart < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :id_carro, :integer
    add_foreign_key :sales, :carts, column: :id_carro, primary_key: :id
  end
end
