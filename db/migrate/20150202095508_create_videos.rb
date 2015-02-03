class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :url
      t.references :step, index: true

      t.timestamps null: false
    end
    add_foreign_key :videos, :steps
  end
end
