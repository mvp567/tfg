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
      t.string "ciutat_naixament", :limit => 25
      t.string "pais_naixament", :limit => 25
      t.string "ciutat_residencia", :limit => 25
      t.string "pais_residencia", :limit => 25
      t.float :punts
      t.timestamps
    end
  end
end