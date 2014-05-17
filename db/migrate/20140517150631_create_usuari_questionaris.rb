class CreateUsuariQuestionaris < ActiveRecord::Migration
  def change
    create_table :usuari_questionaris do |t|
      t.integer :usuari_id
      t.integer :questionari_id
      t.float :nota_treta

      t.timestamps
    end
  end
end
