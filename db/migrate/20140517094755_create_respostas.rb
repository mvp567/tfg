class CreateRespostas < ActiveRecord::Migration
  def change
    create_table :respostas do |t|
      t.text :text
      t.boolean :correcta
      t.integer :pregunta_id
      
      t.timestamps
    end
  end
end
