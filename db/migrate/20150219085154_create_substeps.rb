class CreateSubsteps < ActiveRecord::Migration
  def change
    create_table :substeps do |t|
      t.string :typex
      t.integer :sid
      t.integer :row_order
      t.references :Step, index: true

      t.timestamps null: false
    end
    add_foreign_key :substeps, :Steps
  end
end
