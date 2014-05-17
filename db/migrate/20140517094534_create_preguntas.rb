class CreatePreguntas < ActiveRecord::Migration
  def change
    create_table :preguntas do |t|
      t.text :text
      t.integer :questionari_id

      t.timestamps
    end
  end
end
