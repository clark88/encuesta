class CreateAnswertypes < ActiveRecord::Migration
  def self.up
    create_table :answertypes do |t|
		t.string :bezeichnung
		t.string :beschreibung
      t.timestamps
    end
  end

  def self.down
    drop_table :answertypes
  end
end
