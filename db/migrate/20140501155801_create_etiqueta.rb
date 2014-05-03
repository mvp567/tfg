class CreateEtiqueta < ActiveRecord::Migration
  def change
    create_table :etiqueta do |t|
      t.string :nom

      t.timestamps
    end
  end
end
