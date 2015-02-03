class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :questions, :name
    remove_column :questions, :option3
  end
end
