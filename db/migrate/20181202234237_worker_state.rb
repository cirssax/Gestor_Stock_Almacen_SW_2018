class WorkerState < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :workers, :states, column: :id_estado, primary_key: :id
  end
end
