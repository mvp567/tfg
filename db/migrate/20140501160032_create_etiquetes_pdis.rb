class CreateEtiquetesPdis < ActiveRecord::Migration
  def change
    create_table :etiquetes_pdis do |t|
      t.integer :etiqueta_id
      t.integer :pdi_id
      
      t.timestamps
    end
  end
end
