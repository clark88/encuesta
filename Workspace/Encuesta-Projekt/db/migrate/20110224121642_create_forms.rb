class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :forms do |t|
	  t.references :survey
      t.timestamps
    end
  end

  def self.down
    drop_table :forms
  end
end
