class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :name
      t.string :desc
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :steps, :categories
  end
end
