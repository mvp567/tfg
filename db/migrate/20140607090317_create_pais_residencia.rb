class CreatePaisResidencia < ActiveRecord::Migration
  def change
    create_table :pais_residencia do |t|
      t.integer :pais_id
      t.integer :usuari_id

      t.timestamps
    end
  end
end
