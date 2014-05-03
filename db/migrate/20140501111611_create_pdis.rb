class CreatePdis < ActiveRecord::Migration
  def change
    create_table :pdis do |t|
      t.string :nom
      t.string :observacions
      t.string :horari
      t.string :type
      t.integer :localitzacio_id
      t.integer :usuari_id
      
      # camps específics restaurant:
      t.integer :forquilles
      t.decimal :preu_aprox
      t.integer :classe_restaurant_id

      # camps específics botiga:
      t.integer :classe_botiga_id

      # camps específics museu:
      t.integer :classe_museu_id

      # camps específics entreteniment:
      t.integer :classe_entreteniment_id

      # camps específics hotel:
      t.integer :estrelles

      #coordenades (varis camps?)
      t.timestamps
    end
  end
end
