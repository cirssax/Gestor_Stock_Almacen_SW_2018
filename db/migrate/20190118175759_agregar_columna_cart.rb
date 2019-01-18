class AgregarColumnaCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :precio_actual, :integer
  end
end
