class CreateQuestionaris < ActiveRecord::Migration
  def change
    create_table :questionaris do |t|
      t.integer :ruta_turistica_id
      t.integer :usuari_id #creador
      t.float :param_reputacio
      t.boolean :param_ciutat_naixament
      t.boolean :param_pais_naixament
      t.boolean :param_ciutat_residencia
      t.boolean :param_pais_residencia

      t.timestamps
    end
  end
end
