class AllowNullForPomodoroAchievement < ActiveRecord::Migration[5.1]
  def change
    change_column :teams, :pomodoro_achievement_id, :integer, :null => true
  end
end
