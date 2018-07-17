class ChangeTeamPomodoroColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :teams, :pomodoro_achievement_id, :bigint, :null => true
    change_column_null :teams, :pomodoro_achievement_id, true
  end
end
