class CreateFavorita < ActiveRecord::Migration
  def change
    create_table :favorita do |t|
      t.integer :usuari_id
      t.integer :ruta_turistica_id

      t.timestamps
    end
  end
end
