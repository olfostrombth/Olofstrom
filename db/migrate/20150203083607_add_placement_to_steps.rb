class AddPlacementToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :placement, :integer
  end
end
