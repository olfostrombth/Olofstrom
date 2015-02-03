class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :name
      t.string :desc
      t.references :step, index: true

      t.timestamps null: false
    end
    add_foreign_key :guides, :steps
  end
end
