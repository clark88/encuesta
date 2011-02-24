class CreateUserAnswers < ActiveRecord::Migration
  def self.up
    create_table :user_answers do |t|
      t.boolean :AnswerBoolean
      t.string :AnswerText
      t.float :AnswerRate
      t.references :answer
      t.references :form

      t.timestamps
    end
  end

  def self.down
    drop_table :user_answers
  end
end
