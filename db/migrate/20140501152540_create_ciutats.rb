class CreateCiutats < ActiveRecord::Migration
  def change
    create_table :ciutats do |t|
      t.string :nom
      t.string :moneda
      t.integer :pais_id
      t.timestamps
    end
  end
end
