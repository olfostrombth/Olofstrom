class CreateExaminations < ActiveRecord::Migration
  def change
    create_table :examinations do |t|
      t.string :name
      t.string :desc
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :examinations, :categories
  end
end
