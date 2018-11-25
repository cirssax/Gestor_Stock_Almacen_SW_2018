class FkWorkers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :workers, :roles, column: :id_rol, primary_key: :id
  end
end
