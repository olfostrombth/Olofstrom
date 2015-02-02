class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :desc
      t.references :step, index: true

      t.timestamps null: false
    end
    add_foreign_key :assignments, :steps
  end
end
