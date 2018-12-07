class FkSalesUsers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :sales, :users, column: :id_trabajador, primary_key: :id
  end
end
