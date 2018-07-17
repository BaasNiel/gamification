class AddPomodoroAchievementToTeams < ActiveRecord::Migration[5.1]
  def change
    # This is the achievement that a team's user will be awared once a pomodoro
    # has been completed
    add_reference :teams, :pomodoro_achievement, foreign_key: {to_table: :achievements}
  end
end
