class CreateRutaTuristicas < ActiveRecord::Migration
  def change
    create_table :ruta_turisticas do |t|
      t.string :nom
      t.string :temps
      t.integer :usuari_id
      t.integer :usuari_modificador_id

      t.timestamps
    end
  end
end
