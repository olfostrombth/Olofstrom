class AddColumnToSlideritems < ActiveRecord::Migration
  def change
    add_column :slideritems, :rubrik, :string
  end
end
