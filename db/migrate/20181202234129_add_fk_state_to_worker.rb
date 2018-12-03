class AddFkStateToWorker < ActiveRecord::Migration[5.2]
  def change
    add_column :workers, :id_estado, :integer
  end
end
