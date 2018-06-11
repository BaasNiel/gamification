class AddAdminColumnToTeam < ActiveRecord::Migration[5.1]
  def change
    add_reference(:teams, :admin, foreign_key: {to_table: :users})
  end
end
