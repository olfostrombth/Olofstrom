class AddStuffToDb < ActiveRecord::Migration
  def change
    add_column :video, :placement, :integer
    add_column :guide, :placement, :integer
    add_column :quiz, :placement, :integer
    add_column :assignment, :placement, :integer
  end
end
