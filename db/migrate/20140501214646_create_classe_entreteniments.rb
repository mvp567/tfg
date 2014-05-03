class CreateClasseEntreteniments < ActiveRecord::Migration
  def change
    create_table :classe_entreteniments do |t|
      t.string :nom

      t.timestamps
    end
  end
end
