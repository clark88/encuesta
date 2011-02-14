class CreateSurveytypes < ActiveRecord::Migration
  def self.up
    create_table :surveytypes do |t|
		t.string :bezeichnung
		t.string :beschreibung
      t.timestamps
    end
  end

  def self.down
    drop_table :surveytypes
  end
end
