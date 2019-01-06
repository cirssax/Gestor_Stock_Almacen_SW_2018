class EditCartSale < ActiveRecord::Migration[5.2]
  def change
    remove_column :sales, :id_carro, :int
  end
end
