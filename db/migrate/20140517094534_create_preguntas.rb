class CreatePreguntas < ActiveRecord::Migration
  def change
    create_table :preguntas do |t|
      t.text :text
      t.integer :test_to_pass_id

      t.timestamps
    end
  end
end
