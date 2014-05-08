class CreatePdisRutaturisticas < ActiveRecord::Migration
  def change
    create_table :pdis_rutaturisticas do |t|
      t.integer :pdi_id
      t.integer :ruta_turistica_id

      t.timestamps
    end
  end
end
