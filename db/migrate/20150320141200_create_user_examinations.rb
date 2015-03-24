class CreateUserExaminations < ActiveRecord::Migration
  def change
    create_table :user_examinations do |t|
      t.references :examination, index: true
      t.references :user, index: true
      t.string :msg
      t.boolean :corrected

      t.timestamps null: false
    end
    add_foreign_key :user_examinations, :examinations
    add_foreign_key :user_examinations, :users
  end
end
