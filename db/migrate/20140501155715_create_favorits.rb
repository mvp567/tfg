class CreateFavorits < ActiveRecord::Migration
  def change
    create_table :favorits do |t|
      t.integer :pdi_id
      t.integer :usuari_id

      t.timestamps
    end
  end
end
