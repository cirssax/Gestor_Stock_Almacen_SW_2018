class ColumnaCantidadSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :cantidad, :integer
  end
end
