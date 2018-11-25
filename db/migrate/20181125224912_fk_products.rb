class FkProducts < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :products, :types, column: :id_tipo, primary_key: :id
  end
end
