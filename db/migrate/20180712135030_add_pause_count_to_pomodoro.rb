class AddPauseCountToPomodoro < ActiveRecord::Migration[5.1]
  def change
    add_column :pomodoros, :pauses_count, :integer, null: false, default: 0
  end
end
