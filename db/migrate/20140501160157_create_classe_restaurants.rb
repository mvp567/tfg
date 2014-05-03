class CreateClasseRestaurants < ActiveRecord::Migration
  def change
    create_table :classe_restaurants do |t|
      t.string :nom

      t.timestamps
    end
  end
end
