class CreateRolls < ActiveRecord::Migration
  def self.up
    create_table :rolls do |t|
		t.string :bezeichnung
		t.string :beschreibung
      t.timestamps
    end
  end

  def self.down
    drop_table :rolls
  end
end
