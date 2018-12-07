class FkUsers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :users, :roles, column: :id_rol, primary_key: :id
    add_foreign_key :users, :states, column: :id_estado, primary_key: :id
  end
end
