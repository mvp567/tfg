class CreateValoracios < ActiveRecord::Migration
  def change
    create_table :valoracios do |t|
      t.string :titol
      t.text :opinio
      t.integer :punts
      t.integer :usuari_id
      t.integer :ruta_turistica_id
      t.integer :pdi_id

      t.timestamps
    end
  end
end
