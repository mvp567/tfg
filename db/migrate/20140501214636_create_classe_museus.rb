class CreateClasseMuseus < ActiveRecord::Migration
  def change
    create_table :classe_museus do |t|
      t.string :nom

      t.timestamps
    end
  end
end
