class AddPasswortToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :encrypted_passwort, :string
  end

  def self.down
    remove_column :users, :encrypted_passwort
  end
end
