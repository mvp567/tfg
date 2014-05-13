class AddFieldsToUsuaris < ActiveRecord::Migration
  def self.up
    add_column :usuaris, :sash_id, :integer
    add_column :usuaris, :level, :integer, :default => 0
  end

  def self.down
    remove_column :usuaris, :sash_id
    remove_column :usuaris, :level
  end
end
