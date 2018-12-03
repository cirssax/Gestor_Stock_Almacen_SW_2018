class DeleteColumWorker < ActiveRecord::Migration[5.2]
  def change
    remove_column :workers, :estado
  end
end
