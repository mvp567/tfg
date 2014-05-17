class CreateUsuariTests < ActiveRecord::Migration
  def change
    create_table :usuari_tests do |t|
      t.integer :usuari_id
      t.integer :test_to_pass_id
      t.float :nota_treta

      t.timestamps
    end
  end
end
