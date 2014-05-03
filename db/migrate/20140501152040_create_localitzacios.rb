class CreateLocalitzacios < ActiveRecord::Migration
  def change
    create_table :localitzacios do |t|
      t.string :carrer
      t.string :numero
      t.string :codi_postal
      t.integer :ciutat_id

      t.timestamps
    end
  end
end
