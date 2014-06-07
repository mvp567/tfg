class CreateUsuaris < ActiveRecord::Migration
  def change
    create_table :usuaris do |t|
      t.string "nom", :limit => 25
      t.string "cognom", :limit => 25
      t.string "nom_usuari", :limit => 50
      t.string "email", :limit => 40
      t.string "password_digest"
      t.string "edat", :limit => 3
      t.string "sexe", :limit => 10
      t.integer :pais_id
      t.float :punts
      t.string :coord_lat_browser
      t.string :coord_lng_browser
      t.timestamps
    end
  end
end