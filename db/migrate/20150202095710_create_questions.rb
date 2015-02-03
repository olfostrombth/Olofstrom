class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.string :question
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :answer
      t.references :quiz, index: true

      t.timestamps null: false
    end
    add_foreign_key :questions, :quizzes
  end
end
