class AddRowOrderToComments < ActiveRecord::Migration
  def change
    add_column :comments, :row_order, :integer
  end
end
