class AddStuffToDb < ActiveRecord::Migration
  def change
    add_column :videos, :placement, :integer
    add_column :guides, :placement, :integer
    add_column :quizzes, :placement, :integer
    add_column :assignments, :placement, :integer
  end
end
