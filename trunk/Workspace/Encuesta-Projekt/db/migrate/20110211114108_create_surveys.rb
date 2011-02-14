class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
    	t.string :bezeichnung
		t.boolean :gesperrt
		t.references :surveytype
		t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
