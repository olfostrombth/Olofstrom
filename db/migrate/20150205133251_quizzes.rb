class Quizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :name
      t.references :step, index: true

      t.timestamps null: false
    end
    add_foreign_key :quizzes, :steps
  end
end
