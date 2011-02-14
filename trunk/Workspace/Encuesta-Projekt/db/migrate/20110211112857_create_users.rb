class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
		t.string :name
		t.string :vorname
		t.string :login
		t.string :passwort
		t.string :email
		t.string :salt
		t.references :roll
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
