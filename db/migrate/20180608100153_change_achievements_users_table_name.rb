class ChangeAchievementsUsersTableName < ActiveRecord::Migration[5.1]
  def change
    rename_table :achievements_users_, :user_achievements
  end
end
