class CreatePais < ActiveRecord::Migration
  def change
    create_table :pais do |t|
      t.string :nom

      t.timestamps
    end
  end
end
