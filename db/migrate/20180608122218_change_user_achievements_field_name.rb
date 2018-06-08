class ChangeUserAchievementsFieldName < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_achievements, :achieved_on_date, :date_achieved
  end
end
