class AddApprovedToAchievements < ActiveRecord::Migration[5.1]
  def change
    add_column :achievements, :approved, :boolean, :default => false
  end
end
