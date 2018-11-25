class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.string :descrip_tipo

      t.timestamps
    end
  end
end
