class CreateClasseBotigas < ActiveRecord::Migration
  def change
    create_table :classe_botigas do |t|
      t.string :nom

      t.timestamps
    end
  end
end
