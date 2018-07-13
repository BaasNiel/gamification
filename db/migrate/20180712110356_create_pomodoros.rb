class CreatePomodoros < ActiveRecord::Migration[5.1]
  def change
    create_table :pomodoros do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
