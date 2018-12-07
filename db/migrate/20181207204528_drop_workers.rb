class DropWorkers < ActiveRecord::Migration[5.2]
  def change
    drop_table :workers, force: :cascade
  end
end
