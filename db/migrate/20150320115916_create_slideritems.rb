class CreateSlideritems < ActiveRecord::Migration
  def change
    create_table :slideritems do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
