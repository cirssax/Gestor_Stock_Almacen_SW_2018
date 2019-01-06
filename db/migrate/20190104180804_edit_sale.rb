class EditSale < ActiveRecord::Migration[5.2]
  def change
    remove_column :sales, :id_producto, :int
    remove_column :sales, :cantidad, :int
  end
end
