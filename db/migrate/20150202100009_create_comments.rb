class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :msg
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :categories
  end
end
