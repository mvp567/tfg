class CreatePdis < ActiveRecord::Migration
  def change
    create_table :pdis do |t|
      t.float :punts
      t.string :nom
      t.text :horari
      t.text :fotos_petites
      t.text :fotos_grans
      t.string :telefon
      t.string :web
      t.decimal :preu_aprox
      t.integer :nivell_preu
      t.string :icone
      t.string :type
      t.integer :usuari_id
      t.integer :usuari_modificador_id
      
      # camps localització:
      t.string :adreca
      t.string :codi_postal
      t.string :localitat
      t.string :pais
      t.string :coord_lat
      t.string :coord_lng
      t.text :place_reference

      # nous camps per utilitzar PostGIS
      t.point :lat
      t.point :lng
      t.point :lonlat, :geographic => true
      t.polygon :boundary, :srid => 2285
      
      t.index :lonlat, :spatial => true

      # camps específics restaurant:
      t.integer :forquilles
      t.integer :classe_restaurant_id

      # camps específics botiga:
      t.integer :classe_botiga_id

      # camps específics museu:
      t.integer :classe_museu_id

      # camps específics entreteniment:
      t.integer :classe_entreteniment_id

      # camps específics hotel:
      t.integer :estrelles

      t.timestamps
    end
  end
end
