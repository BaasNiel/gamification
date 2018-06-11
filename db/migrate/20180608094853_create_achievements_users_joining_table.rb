class CreateAchievementsUsersJoiningTable < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements_users_ do |t|
      t.belongs_to :user, index: true
      t.belongs_to :achievement, index: true
      t.datetime :achieved_on_date
      t.timestamps
    end
  end
end
