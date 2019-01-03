class DeteleteDvChangeRutTblUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :dv, :string
    remove_column :users, :rut, :integer
    add_column :users, :rut, :string
  end
end
