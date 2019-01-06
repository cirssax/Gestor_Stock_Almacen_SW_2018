class ChangeColumnCarts < ActiveRecord::Migration[5.2]
  def change
    remove_column :carts, :sales_id, :integer
    add_column :carts, :sale_id, :integer
    add_foreign_key :carts, :sales, column: :sale_id, primary_key: :id
  end
end
