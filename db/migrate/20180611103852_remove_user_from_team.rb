class RemoveUserFromTeam < ActiveRecord::Migration[5.1]
  def change
    remove_column :teams, :user_id
  end
end
