class DeleteSaleCart < ActiveRecord::Migration[5.2]
  def change
    drop_table :sales, force: :cascade
    drop_table :carts, force: :cascade
  end
end
